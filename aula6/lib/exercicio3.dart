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
  var playerMaxWins = 1;
  var maxMachineWins = 5;

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

  checkWinner(player, machine) {
    if (player == 0 && machine == 1 ||
        player == 1 && machine == 2 ||
        player == 2 && machine == 0) {
      return 1;
    } else if (machine == 0 && player == 1 ||
        machine == 1 && player == 2 ||
        machine == 2 && player == 0) {
      return 2;
    } else {
      return 0;
    }
  }

  play() {
    setState(() {
      if (playerMaxWins == 0 && maxMachineWins > 0) {
        machineIndex = (playerIndex == 0)
            ? 1
            : (playerIndex == 1)
                ? 2
                : (playerIndex == 2)
                    ? 0
                    : 0;
        if (checkWinner(playerIndex, machineIndex) == 1) {
          maxMachineWins--;
          winner = 'A máquina venceu!';
        }

        if (maxMachineWins == 0) {
          playerMaxWins = 1;
          maxMachineWins = 5;
        }
        print(playerMaxWins);
        print(maxMachineWins);
      } else {
        machineIndex = Random().nextInt(3);

        if (checkWinner(playerIndex, machineIndex) == 1) {
          maxMachineWins--;
          playerMaxWins = 1;
          winner = 'A máquina venceu!';
        } else if (checkWinner(playerIndex, machineIndex) == 2) {
          playerMaxWins--;
          winner = 'Você venceu!';
        } else {
          maxMachineWins--;
          playerMaxWins = 1;
          winner = 'Empate';
        }

        if (maxMachineWins == 0) {
          playerMaxWins = 1;
          maxMachineWins = 5;
        }

        print(playerMaxWins);
        print(maxMachineWins);
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
