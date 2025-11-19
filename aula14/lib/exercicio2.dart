import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final TextEditingController wordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool loading = false;
  late String definitionFinded = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Dicionário 📘'),
          centerTitle: true,
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            spacing: 20,
            children: [
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Container(
                  margin: EdgeInsets.all(24),
                  child: Column(
                    spacing: 20,
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value == '' || value!.isEmpty) {
                            return 'Digite uma palavra';
                          }

                          return null;
                        },
                        controller: wordController,
                        decoration: InputDecoration(
                          hintText: 'Palavra',
                          icon: Icon(Icons.abc_rounded),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                      FilledButton.icon(
                        style: ButtonStyle(
                          textStyle: WidgetStatePropertyAll(
                            TextStyle(fontWeight: FontWeight.w500),
                          ),
                          iconSize: WidgetStatePropertyAll(16),
                          visualDensity: VisualDensity(horizontal: 4),
                        ),
                        onPressed: () {
                          setState(() {
                            loading = true;
                          });

                          if (!wordController.text.isEmpty) {
                            getWordDictionary();
                          }
                        },
                        label: Text('Buscar'),
                        icon: Icon(Icons.search),
                      ),
                    ],
                  ),
                ),
              ),
              loading
                  ? CircularProgressIndicator()
                  : Container(
                      margin: EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Text(
                            definitionFinded,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  getWordDictionary() async {
    final baseDictionaryUrl = Uri.https(
      'api.dictionaryapi.dev',
      '/api/v2/entries/en/${removerAcentos(wordController.text.toString().toLowerCase())}',
    );
    final response = await http.get(baseDictionaryUrl);
    List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
    final definition = data[0]['meanings'][0]['definitions'][0]['definition']
        .toString();

    setState(() {
      definitionFinded = definition;
      loading = false;
    });
  }

  String removerAcentos(String str) {
    var comAcento =
        'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
    var semAcento =
        'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz';

    for (int i = 0; i < comAcento.length; i++) {
      str = str.replaceAll(comAcento[i], semAcento[i]);
    }

    return str;
  }
}
