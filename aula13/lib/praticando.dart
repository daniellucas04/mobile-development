import 'package:flutter/material.dart';

void main() {
  runApp(const Errada());
}

class Errada extends StatefulWidget {
  const Errada({super.key});

  @override
  State<Errada> createState() => _ErradaState();
}

class _ErradaState extends State<Errada> {
  @override
  Widget build(BuildContext context) {
    String valor = 'ab';
    double numero = 0;

    try {
      numero = double.parse(valor);
    } catch (error) {
      numero = 30;
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(margin: EdgeInsets.all(numero), color: Colors.red),
      ),
    );
  }
}
