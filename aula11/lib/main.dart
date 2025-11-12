import 'package:calculator/model/dados.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

var database;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  database = openDatabase(
    join(await getDatabasesPath(), 'calculadora.db'),
    onCreate: (db, version) {
      return db.execute('''
        CREATE TABLE dados(id INTEGER PRIMARY KEY, screen TEXT, memory TEXT);
        ''');
    },
    version: 1,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Calculadora', home: Calculadora());
  }
}

class Calculadora extends StatefulWidget {
  @override
  _CalculadoraState createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String input = '';
  String memory = '';

  void appendInput(String text) {
    setState(() {
      input += text;
    });
  }

  void clearInput() {
    setState(() {
      input = '';
    });
  }

  void calculate() {
    try {
      final regex = RegExp(r'(\d+(\.\d*)?|\.\d+|[-+*/^()])');
      Iterable<Match> matches = regex.allMatches(input);

      List<String> tokens = matches.map((match) => match.group(0)!).toList();

      double result = _simpleEval(tokens);

      setState(() {
        if (result == result.toInt()) {
          input = result.toInt().toString();
        } else {
          input = result.toString();
        }
      });

      var dado = Dados(screen: input, memory: memory);
      insertDados(dado);
    } catch (e) {
      setState(() {
        input = 'Erro';
      });
    }
  }

  void readMemory() {
    setState(() {
      input = memory;
    });
  }

  void addToMemory() {
    if (memory == '') {
      setState(() {
        memory += input;
      });
    } else {
      var actualValue = double.parse(input);
      var beforeValue = double.parse(memory);
      var result = (actualValue + beforeValue);

      setState(() {
        if (result == result.toInt()) {
          input = result.toInt().toString();
        } else {
          input = result.toString();
        }

        memory = input;
      });
    }
  }

  void subToMemory() {
    if (memory == '') {
      setState(() {});
    } else {
      var actualValue = double.parse(input);
      var beforeValue = double.parse(memory);
      var result = (beforeValue - actualValue);

      setState(() {
        if (result == result.toInt()) {
          input = result.toInt().toString();
        } else {
          input = result.toString();
        }

        memory = input;
      });
    }
  }

  void clearMemory() {
    setState(() {
      memory = '';
      input = memory;
    });
  }

  double _simpleEval(List<String> tokens) {
    double result = double.parse(tokens[0]);

    for (int i = 1; i < tokens.length; i += 2) {
      String operator = tokens[i];
      double num = double.parse(tokens[i + 1]);

      switch (operator) {
        case '+':
          result += num;
          break;
        case '-':
          result -= num;
          break;
        case '*':
          result *= num;
          break;
        case '/':
          result /= num;
          break;
        default:
          throw Exception('Operador desconhecido');
      }
    }
    return result;
  }

  Future<void> insertDados(Dados dados) async {
    final db = await database;

    await db.insert(
      'dados',
      dados.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Dados>> dados() async {
    final db = await database;
    final List<Map<String, Object?>> dadosMaps = await db.query('dados');

    return [
      for (final {'screen': screen as String, 'memory': memory as String}
          in dadosMaps)
        Dados(screen: screen, memory: memory),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculadora')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FutureBuilder<List<Dados>>(
              future: dados(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Erro ao carregar histórico: ${snapshot.error}',
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('Nenhum histórico encontrado'),
                  );
                }

                final historico = snapshot.data!;

                return Expanded(
                  child: ListView.builder(
                    itemCount: historico.length,
                    itemBuilder: (context, index) {
                      final dado = historico[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            dado.screen,
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
            Text(
              input,
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton('MR'),
                _buildButton('MC'),
                _buildButton('M+'),
                _buildButton('M-'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton('7'),
                _buildButton('8'),
                _buildButton('9'),
                _buildButton('/'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton('4'),
                _buildButton('5'),
                _buildButton('6'),
                _buildButton('*'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton('1'),
                _buildButton('2'),
                _buildButton('3'),
                _buildButton('-'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton('0'),
                _buildButton('.'),
                _buildButton('='),
                _buildButton('+'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: clearInput,
                  style: ElevatedButton.styleFrom(
                    elevation: 0.2,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  ),
                  child: Text('C', style: TextStyle(fontSize: 24)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String text) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: ElevatedButton(
        onPressed: () {
          if (text == '=') {
            calculate();
          } else if (text == 'MR') {
            readMemory();
          } else if (text == 'MC') {
            clearMemory();
          } else if (text == 'M+') {
            addToMemory();
          } else if (text == 'M-') {
            subToMemory();
          } else {
            appendInput(text);
          }
        },
        style: ElevatedButton.styleFrom(
          elevation: 0.2,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          shape: CircleBorder(),
        ),
        child: Text(text, style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
