import 'package:aula8/pergunta.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    Pergunta('Em que ano ocorreu a Revolução Francesa?', '1788', false),
    Pergunta('Quem pintou a Mona Lisa?', 'Leonardo da Vinci', true),
    Pergunta('Qual é o elemento químico representado pelo símbolo "O"?',
        'Nitrogênio', true),
    Pergunta('Qual é o rio mais longo do mundo?', 'Rio Amazonas', false),
    Pergunta('Quem foi o primeiro presidente dos Estados Unidos?',
        'George Washington', true),
    Pergunta('Qual é o país mais populoso do mundo?', 'China', true),
    Pergunta('Qual é a fórmula química da água?', 'H2O', true),
    Pergunta(
        'Quem é conhecido como o "Pai da Física"?', 'Albert Einstein', false),
  ];

  saveState() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt('numeroPergunta', numeroPergunta);
  }

  getState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      numeroPergunta = prefs.getInt('numeroPergunta')!;
    });
  }

  @override
  void initState() {
    super.initState();
    getState();
  }

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

                    saveState();
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

                        numeroPergunta++;
                        if (numeroPergunta >= perguntas.length) {
                          numeroPergunta = 0;
                        }

                        saveState();
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
