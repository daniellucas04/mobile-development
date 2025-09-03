import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var numero1 = '';
  var numero2 = '';
  var somaApertado = false;
  var resultadoApertado = false;
  var resultado = 0;

  void calculadoraPressionada(int numero) {
    setState(() {
      if (!somaApertado) {
        numero1 += numero.toString();
      } else {
        numero2 += numero.toString();
      }

      resultadoApertado = false;
    });

    print('Operador 1: $numero1');
    print('Operador 2: $numero2');
    print('Soma apertado: $somaApertado');
    print('Resultado: ');
  }

  void calcularResultado() {
    setState(() {
      resultado = int.parse(numero1) + int.parse(numero2);
      resultadoApertado = true;

      numero1 = '';
      numero2 = '';
      somaApertado = false;
    });

    print('Operador 1: $numero1');
    print('Operador 2: $numero2');
    print('Soma apertado $somaApertado');
    print('Resultado: $resultado');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: false),
      home: Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: Text(
            'Homepage',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(237, 0, 130, 236),
                  Color.fromARGB(255, 1, 137, 137),
                ],
                begin: Alignment.topLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(237, 0, 130, 236),
                Color.fromARGB(255, 1, 137, 137),
              ],
              begin: Alignment.topLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(
                      border: BoxBorder.all(width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: Center(
                            child: Text(
                              resultadoApertado
                                  ? resultado.toString()
                                  : "$numero1 + $numero2",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () => calculadoraPressionada(7),
                        child: Text(
                          "7",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ),
                      TextButton(
                        onPressed: () => calculadoraPressionada(8),
                        child: Text(
                          "8",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ),
                      TextButton(
                        onPressed: () => calculadoraPressionada(9),
                        child: Text(
                          "9",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () => calculadoraPressionada(4),
                        child: Text(
                          "4",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ),
                      TextButton(
                        onPressed: () => calculadoraPressionada(5),
                        child: Text(
                          "5",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ),
                      TextButton(
                        onPressed: () => calculadoraPressionada(6),
                        child: Text(
                          "6",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () => calculadoraPressionada(1),
                        child: Text(
                          "1",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ),
                      TextButton(
                        onPressed: () => calculadoraPressionada(2),
                        child: Text(
                          "2",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ),
                      TextButton(
                        onPressed: () => calculadoraPressionada(3),
                        child: Text(
                          "3",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () => calculadoraPressionada(0),
                        child: Text(
                          "0",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ),
                      TextButton(
                        onPressed: () => calcularResultado(),
                        child: Text(
                          "=",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            somaApertado = true;
                          });
                        },
                        child: Text(
                          "+",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
