import 'package:aula8/pergunta.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Perguntas());
}

class Perguntas extends StatefulWidget {
  const Perguntas({super.key});

  @override
  State<Perguntas> createState() => _PerguntasState();
}

class _PerguntasState extends State<Perguntas> {
  List<Widget> resultado = [];
  int numeroPergunta = 0;
  List perguntas = [
    Pergunta('Qual é a capital da França?', 'Madrid', false),
    Pergunta('Quem escreveu "Dom Quixote"?', 'Miguel de Cervantes', true),
    Pergunta('Qual é o maior planeta do sistema solar?', 'Terra', false),
  ];

  List respostas = [false, true, false];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Center(
                  child: Text(
                    perguntas[numeroPergunta].texto,
                    style:
                        const TextStyle(fontFamily: 'Quicksand', fontSize: 32),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  perguntas[numeroPergunta].resposta,
                  style: TextStyle(fontFamily: 'Quicksand', fontSize: 28),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    if (perguntas[numeroPergunta].correta) {
                      resultado.add(
                        const Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                      );
                    } else {
                      resultado.add(
                        const Icon(
                          Icons.close,
                          color: Colors.red,
                        ),
                      );
                    }

                    numeroPergunta++;
                    if (numeroPergunta >= perguntas.length) {
                      numeroPergunta = 0;
                    }
                  });
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  minimumSize: Size(200, 60),
                ),
                child: const Text(
                  'SIM',
                  style: TextStyle(fontFamily: 'Quicksand', fontSize: 22),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextButton(
                    onPressed: () {
                      setState(() {
                        if (!perguntas[numeroPergunta].correta) {
                          resultado.add(
                            const Icon(
                              Icons.check,
                              color: Colors.green,
                            ),
                          );
                        } else {
                          resultado.add(
                            const Icon(
                              Icons.close,
                              color: Colors.red,
                            ),
                          );
                        }

                        numeroPergunta--;
                        if (numeroPergunta < 0) {
                          numeroPergunta = perguntas.length - 1;
                        }
                      });
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      minimumSize: Size(200, 60),
                    ),
                    child: const Text(
                      'NÃO',
                      style: TextStyle(fontFamily: 'Quicksand', fontSize: 22),
                    )),
              ),
              Row(
                children: resultado,
              )
            ],
          ),
        ),
      ),
    );
  }
}
