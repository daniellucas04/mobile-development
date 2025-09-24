import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

const double height = 80.0;
const Color fundo = Color(0xFF1E164B);
Color? fundoSelecionadoMasc;
Color? fundoSelecionadoFem;

enum Sexo {
  masculino,
  feminino,
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double altura = 150;
  double peso = 60;

  void _changeSelected(Sexo sexo) {
    if (sexo == Sexo.masculino) {
      setState(() {
        fundoSelecionadoMasc = Color.fromARGB(255, 45, 11, 237);
        fundoSelecionadoFem = null;
      });
    } else {
      setState(() {
        fundoSelecionadoFem = Color.fromARGB(255, 45, 11, 237);
        fundoSelecionadoMasc = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double imc = peso / (pow((altura / 100), 2));
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('IMC')),
        body: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        _changeSelected(Sexo.masculino);
                      },
                      child: Caixa(
                        cor: fundoSelecionadoMasc ?? fundo,
                        filho: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.male,
                              size: 80,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'MASC',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        _changeSelected(Sexo.feminino);
                      },
                      child: Caixa(
                        cor: fundoSelecionadoFem ?? fundo,
                        filho: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.female,
                              size: 80,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'FEM',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Caixa(
                cor: fundo,
                filho: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Altura:',
                      style: TextStyle(fontSize: 24, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      altura.toStringAsFixed(2),
                      style: TextStyle(fontSize: 24),
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        thumbColor: Colors.red,
                        thumbShape: RoundSliderThumbShape(
                          enabledThumbRadius: 10,
                        ),
                        overlayShape: RoundSliderOverlayShape(
                          overlayRadius: 20,
                        ),
                      ),
                      child: Slider(
                        value: altura,
                        min: 60,
                        max: 260,
                        onChanged: (value) {
                          setState(
                            () {
                              altura = value;
                            },
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Caixa(
                      cor: fundo,
                      filho: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Peso',
                            style: TextStyle(fontSize: 24, color: Colors.grey),
                          ),
                          Text(
                            peso.toString(),
                            style: TextStyle(fontSize: 32),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 10,
                            children: [
                              TextButton(
                                style: ButtonStyle(
                                  foregroundColor:
                                      WidgetStatePropertyAll(Colors.grey),
                                ),
                                onPressed: () {
                                  setState(() {
                                    peso += 0.5;
                                  });
                                },
                                child: Icon(
                                  Icons.add,
                                  size: 30,
                                ),
                              ),
                              TextButton(
                                style: ButtonStyle(
                                  foregroundColor:
                                      WidgetStatePropertyAll(Colors.grey),
                                ),
                                onPressed: () {
                                  setState(() {
                                    peso -= 0.5;
                                  });
                                },
                                child: Icon(
                                  Icons.remove,
                                  size: 30,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Caixa(
                      cor: fundo,
                      filho: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Resultado:',
                            style: TextStyle(fontSize: 24, color: Colors.grey),
                          ),
                          Text(
                            imc.toStringAsFixed(2),
                            style: TextStyle(fontSize: 24),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Color(0xFF638ED6),
              width: double.infinity,
              height: height, // constante!
              margin: EdgeInsets.only(top: 10.0),
            ),
          ],
        ),
      ),
    );
  }
}

class Caixa extends StatelessWidget {
  final Color cor;
  final Widget? filho;

  @override
  const Caixa({super.key, required this.cor, this.filho});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: cor,
      ),
      child: filho,
    );
  }
}
