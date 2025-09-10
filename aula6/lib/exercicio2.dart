import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  var playerIndex = 0;
  var machineIndex = 0;
  var winner = '';

  var imagens = [
    'https://t3.ftcdn.net/jpg/01/23/14/80/360_F_123148069_wkgBuIsIROXbyLVWq7YNhJWPcxlamPeZ.jpg',
    'https://i.ebayimg.com/00/s/MTIwMFgxNjAw/z/KAcAAOSwTw5bnTbW/\$_57.JPG',
    'https://t4.ftcdn.net/jpg/02/55/26/63/360_F_255266320_plc5wjJmfpqqKLh0WnJyLmjc6jFE9vfo.jpg'
  ];

  changeImageVisible() {
    setState(
      () {
        if (++playerIndex == imagens.length) {
          playerIndex = 0;
        }
      },
    );
  }

  play() {
    setState(() {
      machineIndex = Random().nextInt(3);

      winner = 'Empate';
      if (playerIndex == 0 && machineIndex == 1 ||
          playerIndex == 1 && machineIndex == 2 ||
          playerIndex == 2 && machineIndex == 0) {
        winner = 'A máquina ganhou!';
      }

      if (machineIndex == 0 && playerIndex == 1 ||
          machineIndex == 1 && playerIndex == 2 ||
          machineIndex == 2 && playerIndex == 0) {
        winner = 'Você ganhou!';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          previousPageTitle: 'Voltar',
          middle: Text('Aula 6 do Maurão'),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(winner),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    imagens[playerIndex].toString(),
                    width: 150,
                  ),
                  Image.network(
                    imagens[machineIndex].toString(),
                    width: 150,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CupertinoButton.filled(
                    onPressed: changeImageVisible,
                    child: const Text('Escolher'),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  CupertinoButton.filled(
                    onPressed: play,
                    child: const Text('Jogar'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
    ;
  }
}
