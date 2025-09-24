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
  final numeroPergunta = 0;
  List numeros = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  late List<Widget> tabuada = [];
  late TextEditingController _respostaController;

  List<Widget> criaTabuada() {
    for (var item in numeros) {
      for (var i = 1; i <= 10; i++) {
        tabuada.add(Text(
          "$item x $i = ",
          style: TextStyle(fontSize: 30),
        ));
      }
    }

    return tabuada;
  }

  @override
  void initState() {
    super.initState();
    _respostaController = TextEditingController();
    criaTabuada();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              tabuada[numeroPergunta],
              TextField(
                controller: _respostaController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter a search term',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
