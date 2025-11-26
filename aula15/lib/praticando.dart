import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  late String? title = null;
  late String? titulo = null;
  late double? nota = 0;
  late String? freq = null;

  @override
  void initState() {
    super.initState();

    _fetchSuap();
    _fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(24),
              child: Text(
                title ?? 'Notícia não encontrada',
                style: TextStyle(fontSize: 20, height: 1.5),
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(24),
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(
                  color: nota! > 6 ? Colors.green : Colors.red,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 18,
                children: [
                  Text(
                    'Matéria: ${titulo ?? 'Sem matéria'}',
                    style: TextStyle(fontSize: 20, height: 1.5),
                  ),
                  Text(
                    'Nota: ${nota ?? 'Sem nora'}',
                    style: TextStyle(fontSize: 20, height: 1.5),
                  ),
                  Text(
                    'Frequência: ${freq ?? 'Sem frequência'}',
                    style: TextStyle(fontSize: 20, height: 1.5),
                  ),
                  Row(
                    children: [
                      Text('Resultado: ', style: TextStyle(fontSize: 20)),
                      Text(
                        '${nota! > 6 ? 'Aprovado' : 'Reprovado'}',
                        style: TextStyle(
                          color: nota! > 6 ? Colors.green : Colors.red,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _fetchNews() async {
    final baseG1News = Uri.https(
      'g1.globo.com',
      '/educacao/enem/2025/noticia/2025/11/25/mensagens-de-edcley-indicam-acesso-previo-a-mais-2-questoes-do-enem-nao-anuladas-pelo-inep-pode-marcar-sem-medo-de-ser-feliz-nem-leia.ghtml',
    );

    final response = await http.get(baseG1News);
    if (response.statusCode == 200) {
      final document = parse(response.body);

      final titulo = document.querySelector('h1')?.text;
      setState(() {
        title = titulo;
      });
    }
  }

  void _fetchSuap() async {
    String materia =
        "SUP.13181 (BRTTOPA) - TÓPICOS AVANÇADOS	60,00	80 Aulas 68 0	100% Cursando (Aguarda Carga Horária) 10,00	0	10,00	-	0";

    List<String> formatString = materia
        .replaceAll(',', '.')
        .replaceAll('\t', '@')
        .replaceAll(' ', '#')
        .split(RegExp(r'[#;@]'));

    print(formatString);
    setState(() {
      titulo = formatString[3] + ' ' + formatString[4];
      nota = double.parse(formatString[15]);
      freq = formatString[10];
    });
  }
}
