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
  List<String> paragraph = [];

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
            Center(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title ?? 'Não encontrado',
                        style: TextStyle(fontSize: 24),
                      ),
                      Divider(),
                      // Torna o conteúdo abaixo do título rolável
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              alignment: WrapAlignment.start,
                              runSpacing: 10,
                              spacing: 10,
                              children: paragraph.map((item) {
                                return ActionChip.elevated(
                                  onPressed: () async {
                                    await _wordAlert(
                                      item,
                                    ); // Passando a palavra clicada
                                  },
                                  label: Text(
                                    item,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  elevation: 1,
                                );
                              }).toList(),
                            ),
                          ],
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

    final titleElement = document.querySelector('.mw-page-title-main');
    final paragraphs = document.querySelectorAll('#mw-content-text p');

    String? firstParagraph;

    // Encontrando o primeiro parágrafo não vazio
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
    });
  }

  _wordAlert(String word) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          title: Text(word),
          content: Text('Word explanation', style: TextStyle(fontSize: 16)),
          actions: [
            Flex(
              spacing: 12,
              direction: Axis.horizontal,
              children: [
                FilledButton.icon(
                  onPressed: () {},
                  label: Text(
                    'Não entendi',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(BorderSide(width: 1)),
                    backgroundColor: MaterialStateProperty.all(
                      Colors.transparent,
                    ),
                  ),
                  icon: Icon(Icons.refresh_rounded, color: Colors.black),
                ),
                FilledButton.icon(
                  onPressed: () {},
                  label: Text(
                    'Entendi',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                  ),
                  icon: Icon(Icons.check_circle_outline),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
