import 'package:aula10/component/botao.dart';
import 'package:aula10/tela2.dart';
import 'package:flutter/material.dart';

class Tela1 extends StatelessWidget {
  const Tela1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tela 1')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 20,
          children: [
            BotaoRedondo(
              icone: Icons.error,
              text: 'Error',
              function: () {
                print('erro!!');
              },
            ),
            Text('conteúdo:'),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/segunda');
              },
              child: Text('Ir para tela 2'),
            ),
          ],
        ),
      ),
    );
  }
}
