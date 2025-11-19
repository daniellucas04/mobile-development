import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int yourPoints = 0;
  int enemyPoints = 0;
  late String yourMonsterName = '';
  late String yourMonsterStrength = '';
  late String enemyMonsterName = '';
  late String enemyMonsterStrength = '';

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Jogo 🕹'),
          centerTitle: true,
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: Container(
            margin: EdgeInsets.all(30),
            child: Column(
              spacing: 20,
              children: [
                loading
                    ? CircularProgressIndicator()
                    : Container(
                        margin: EdgeInsets.all(24),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Card(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(),
                                  child: Container(
                                    width: 200,
                                    height: 200,
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Text(
                                          '👾',
                                          style: TextStyle(fontSize: 55),
                                        ),
                                        Text(
                                          'Você: ${yourPoints.toString()}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(yourMonsterName),
                                        Text(yourMonsterStrength),
                                      ],
                                    ),
                                  ),
                                ),
                                Card(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(),
                                  child: Container(
                                    width: 200,
                                    height: 200,
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Text(
                                          '🤖',
                                          style: TextStyle(fontSize: 55),
                                        ),
                                        Text(
                                          'Adversário: ${enemyPoints.toString()}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(enemyMonsterName),
                                        Text(enemyMonsterStrength),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                Row(
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        style: ButtonStyle(
                          padding: WidgetStatePropertyAll(EdgeInsets.all(14)),
                        ),
                        onPressed: () {
                          setState(() {
                            loading = true;
                          });
                          _loadGameData();
                        },
                        icon: Icon(Icons.gamepad, size: 20),
                        label: Text('Jogar', style: TextStyle(fontSize: 20)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _loadGameData() async {
    final random = Random();
    final baseUrl = Uri.https('api.open5e.com', '/v1/monsters/', {'page': '2'});

    final response = await http.get(baseUrl);
    Map<String, dynamic> data =
        jsonDecode(response.body) as Map<String, dynamic>;

    var randomIndex = random.nextInt(50);
    var enemyRandomIndex = random.nextInt(50);

    final monsterName = data['results'][randomIndex]['name'];
    final monsterStrength = data['results'][randomIndex]['strength'].toString();

    final monsterEnemyName = data['results'][enemyRandomIndex]['name'];
    final monsterEnemyStrength = data['results'][enemyRandomIndex]['strength']
        .toString();

    setState(() {
      yourMonsterName = monsterName;
      yourMonsterStrength = monsterStrength.toString();

      enemyMonsterName = monsterEnemyName;
      enemyMonsterStrength = monsterEnemyStrength.toString();

      if (int.parse(yourMonsterStrength) < int.parse(monsterEnemyStrength)) {
        enemyPoints += 1;
      } else {
        yourPoints += 1;
      }

      loading = false;
    });
  }
}
