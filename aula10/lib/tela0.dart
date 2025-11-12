import 'package:aula10/component/botao.dart';
import 'package:aula10/tela2.dart';
import 'package:flutter/material.dart';

class Tela0 extends StatelessWidget {
  const Tela0({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tela 0')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 20,
          children: [
            BotaoRedondo(
              icone: Icons.one_k_outlined,
              text: 'Tela 1',
              function: () {
                Navigator.pushNamed(context, '/primeira');
              },
            ),
            BotaoRedondo(
              icone: Icons.two_k_outlined,
              text: 'Tela 2',
              function: () {
                Navigator.pushNamed(context, '/segunda');
              },
            ),
          ],
        ),
      ),
    );
  }
}
