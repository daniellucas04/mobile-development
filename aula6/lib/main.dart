import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
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
  late AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();

    audioPlayer = AudioPlayer();
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
            child: CupertinoButton(
          child: Image.asset('imagens/maquina.jpeg'),
          onPressed: () async {
            print('tocou');
            await audioPlayer.play(DeviceFileSource('imagens/audio.mp3'));
          },
        )),
      ),
    );
  }
}
