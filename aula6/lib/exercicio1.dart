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
  var index = 0;
  var imagens = [
    'https://t3.ftcdn.net/jpg/01/23/14/80/360_F_123148069_wkgBuIsIROXbyLVWq7YNhJWPcxlamPeZ.jpg',
    'https://i.ebayimg.com/00/s/MTIwMFgxNjAw/z/KAcAAOSwTw5bnTbW/\$_57.JPG',
    'https://t4.ftcdn.net/jpg/02/55/26/63/360_F_255266320_plc5wjJmfpqqKLh0WnJyLmjc6jFE9vfo.jpg'
  ];

  changeImageVisible() {
    setState(
      () {
        if (++index == imagens.length) {
          index = 0;
        }
      },
    );
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
              Image.network(imagens[index].toString()),
              CupertinoButton.filled(
                onPressed: changeImageVisible,
                child: const Text('Escolher'),
              )
            ],
          ),
        ),
      ),
    );
    ;
  }
}
