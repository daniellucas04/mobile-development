import 'package:aula10/tela0.dart';
import 'package:aula10/tela1.dart';
import 'package:aula10/tela2.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => Tela0(),
        '/primeira': (context) => Tela1(),
        '/segunda': (context) => Tela2(),
      },
    );
  }
}
