import 'package:flutter/material.dart';

class Tela2 extends StatelessWidget {
  const Tela2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tela 2')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 20,
          children: [
            Text('conteúdo:'),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/primeira');
              },
              child: Text('Voltar para tela 1'),
            ),
          ],
        ),
      ),
    );
  }
}
