import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

enum Animal {
  cat,
  dog,
}

const double height = 80.0;
const Color fundo = Color(0xFF1E164B);
Color? fundoCat;
Color? fundoDog;
Animal selectedAnimal = Animal.cat;
num resultado = 0;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double idade = 1;
  double peso = 9.07;

  void _changeSelected(Animal animal) {
    selectedAnimal = animal;
    if (animal == Animal.cat) {
      setState(() {
        fundoCat = Color.fromARGB(255, 45, 11, 237);
        fundoDog = null;
      });
    } else {
      setState(() {
        fundoDog = Color.fromARGB(255, 45, 11, 237);
        fundoCat = null;
      });
    }
  }

  void _calculateHumanAge(idade, peso) {
    if (selectedAnimal == Animal.cat) {
      setState(() {
        if (idade == 1) {
          resultado = 15;
        } else if (idade == 2) {
          resultado = 24;
        } else {
          resultado = (24 + (idade - 2) * 4);
        }
      });
    } else {
      setState(() {
        if (peso <= 10) {
          // Cachorros de pequeno porte
          if (idade == 1) {
            resultado = 15;
          } else if (idade == 2) {
            resultado = 24;
          } else {
            resultado = 24 + (idade - 2) * 4;
          }
        } else if (peso <= 25) {
          // Cachorros de porte médio
          if (idade == 1) {
            resultado = 15;
          } else if (idade == 2) {
            resultado = 24;
          } else {
            resultado = 24 + (idade - 2) * 5;
          }
        } else {
          // Cachorros de grande porte
          if (idade == 1) {
            resultado = 15;
          } else if (idade == 2) {
            resultado = 24;
          } else {
            resultado = 24 + (idade - 2) * 6;
          }
        }
        print(resultado);
      });
    }
  }

  @override
  void initState() {
    _calculateHumanAge(idade, 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Idade')),
        body: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        _changeSelected(Animal.cat);
                      },
                      child: Caixa(
                        cor: fundoCat ?? fundo,
                        filho: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.pets,
                              size: 80,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Gato',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        _changeSelected(Animal.dog);
                      },
                      child: Caixa(
                        cor: fundoDog ?? fundo,
                        filho: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.pets,
                              size: 80,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Cachorro',
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
            selectedAnimal == Animal.cat
                ? Expanded(
                    child: Caixa(
                      cor: fundo,
                      filho: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Idade',
                            style: TextStyle(fontSize: 24, color: Colors.grey),
                          ),
                          Text(
                            idade.toStringAsFixed(0),
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
                                    idade += 1;
                                    _calculateHumanAge(idade, 0);
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
                                    if (idade == 1) {
                                      return;
                                    }
                                    idade -= 1;
                                    _calculateHumanAge(idade, 0);
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
                  )
                : Container(
                    height: 200,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Caixa(
                            cor: fundo,
                            filho: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Idade',
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.grey),
                                ),
                                Text(
                                  idade.toStringAsFixed(0),
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
                                          idade += 1;
                                          _calculateHumanAge(idade, peso);
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
                                          if (idade == 1) {
                                            return;
                                          }
                                          idade -= 1;
                                          _calculateHumanAge(idade, peso);
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
                                  'Peso',
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.grey),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  peso.toStringAsFixed(2),
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
                                    value: peso,
                                    min: 5,
                                    max: 100,
                                    onChanged: (value) {
                                      setState(
                                        () {
                                          peso = value;
                                          _calculateHumanAge(idade, peso);
                                        },
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
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
                            'Resultado:',
                            style: TextStyle(fontSize: 24, color: Colors.grey),
                          ),
                          Text(
                            resultado.toStringAsFixed(2),
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
              height: height,
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
