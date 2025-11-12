import 'package:flutter/material.dart';

class Resultado extends StatelessWidget {
  const Resultado({super.key, required this.valor, required this.comentario});

  final int valor;
  final String comentario;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [Text(comentario), Text(valor.toString())]),
    );
  }
}
