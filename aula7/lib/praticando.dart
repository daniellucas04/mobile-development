import 'dart:math';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _radioController;
  double resultado = 0.0;
  late int date;

  void _showDatePicker() {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 400,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: CupertinoDatePicker(
            initialDateTime: DateTime.now(),
            mode: CupertinoDatePickerMode.monthYear,
            use24hFormat: true,
            showDayOfWeek: true,
            maximumYear: DateTime.now().year,
            onDateTimeChanged: (DateTime newDate) {
              setState(() {
                date = DateTime.now().difference(newDate).inDays ~/ 365;
              });
            },
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _radioController = TextEditingController();
    date = 0;
  }

  @override
  void dispose() {
    _radioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        previousPageTitle: 'Voltar',
        middle: Text('Aula 7 do Maurão'),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Área do círculo",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(resultado.toStringAsFixed(1)),
            Padding(
              padding: const EdgeInsets.all(20),
              child: CupertinoTextField(
                placeholder: '2.0',
                keyboardType: TextInputType.number,
                controller: _radioController,
              ),
            ),
            CupertinoButton(
              color: CupertinoColors.darkBackgroundGray,
              onPressed: () {
                setState(() {
                  resultado = pi * (pow(int.parse(_radioController.text), 2));
                  _radioController.text = '';
                });
              },
              child: const Text('Calcular área'),
            ),
            const SizedBox(
              height: 20,
            ),
            CupertinoButton(
              color: CupertinoColors.activeBlue,
              onPressed: _showDatePicker,
              child: const Text('Selecionar data de nascimento'),
            ),
            const SizedBox(
              height: 20,
            ),
            Text('$date ano(s)'),
            const SizedBox(
              height: 200,
            ),
            Row(
              children: [
                Column(
                  children: [],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
