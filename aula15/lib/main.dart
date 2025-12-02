import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wiki English',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Wiki English'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController urlController = TextEditingController();
  String? title;
  String wordExplanation = '';
  List<String> paragraph = [];

  /// Lista de palavras clicadas
  List<String> clickedWords = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        title: Row(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.book, size: 28),
            Text('Wiki English', style: TextStyle(fontSize: 28)),
          ],
        ),
        elevation: 1,
      ),
      body: Container(
        margin: EdgeInsets.all(14),
        padding: EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      hintText: 'https://pt.wikipedia.org/wiki/',
                      labelText: 'Wiki url',
                      prefixIcon: Icon(Icons.link, size: 28),
                      floatingLabelAlignment: FloatingLabelAlignment.center,
                    ),
                    controller: urlController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Url inválida';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FilledButton.icon(
                        icon: Icon(Icons.search),
                        onPressed: _searchWiki,
                        label: Text('Search'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            SizedBox(
              height: 450,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title ?? 'Não encontrado',
                        style: TextStyle(fontSize: 24),
                      ),
                      Divider(),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            runSpacing: 10,
                            spacing: 10,
                            children: paragraph.map((item) {
                              final isClicked = clickedWords.contains(item);

                              return ActionChip(
                                onPressed: () async {
                                  setState(() {
                                    if (!clickedWords.contains(item)) {
                                      clickedWords.add(item);
                                    }
                                  });

                                  await _wordAlert(item);
                                },
                                label: Text(
                                  item,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: isClicked
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                                backgroundColor: isClicked
                                    ? Colors.deepPurple
                                    : Colors.grey.shade200,
                                elevation: isClicked ? 4 : 1,
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _searchWiki() async {
    final baseUrl = urlController.text;
    final baseWikiUrl = Uri.parse(baseUrl);

    var response = await http.get(baseWikiUrl);
    final document = parse(response.body);

    final titleElement = document.querySelector('.mw-first-heading');
    final paragraphs = document.querySelectorAll('#mw-content-text p');

    String? firstParagraph;

    for (final p in paragraphs) {
      final text = p.text.trim();
      if (text.isNotEmpty) {
        firstParagraph = text;
        break;
      }
    }

    setState(() {
      title = titleElement?.text ?? 'Título não encontrado';
      paragraph = firstParagraph?.split(RegExp(r'\s+')) ?? [];
      clickedWords = []; // limpa estado ao buscar novo texto
    });
  }

  _wordAlert(String word) async {
    await _wordExplanation(word);
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          title: Text(word),
          content: Text(wordExplanation),
          actions: [
            Flex(
              spacing: 8,
              direction: Axis.horizontal,
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () => Navigator.pop(context),
                    label: Text(
                      'Voltar',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ButtonStyle(
                      side: WidgetStateProperty.all(BorderSide(width: 1)),
                      backgroundColor: WidgetStateProperty.all(
                        Colors.transparent,
                      ),
                    ),
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                  ),
                ),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () => Navigator.pop(context),
                    label: Text(
                      'Entendi',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.green),
                    ),
                    icon: Icon(Icons.check_circle_outline),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  _wordExplanation(word) async {
    var baseUrl = Uri.parse(
      'https://api.dictionaryapi.dev/api/v2/entries/en/$word',
    );

    var response = await http.get(baseUrl);
    var data = jsonDecode(response.body);

    if (data is List) {
      // Resposta válida
      setState(() {
        wordExplanation =
            data[0]['meanings'][0]['definitions'][0]['definition'];
      });
    } else {
      // Resposta de erro da API
      setState(() {
        wordExplanation = data['message'] ?? 'No definition found.';
      });
    }
  }
}
