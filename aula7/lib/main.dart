import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
      routes: <String, WidgetBuilder>{
        '/area': (BuildContext context) => const AreaScreen(),
        '/calcular_area': (BuildContext context) => const CalculateAreaScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
            CupertinoButton(
              child: Text('Iniciar'),
              onPressed: () {
                Navigator.pushNamed(context, '/area');
              },
            )
          ],
        ),
      ),
    );
  }
}

class AreaScreen extends StatefulWidget {
  const AreaScreen({super.key});

  @override
  State<AreaScreen> createState() => _AreaScreenState();
}

class _AreaScreenState extends State<AreaScreen> {
  late TextEditingController _areaController;

  @override
  void initState() {
    super.initState();
    _areaController = TextEditingController();
  }

  @override
  void dispose() {
    _areaController.dispose();
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
            Padding(
              padding: const EdgeInsets.all(20),
              child: CupertinoTextField(
                keyboardType: TextInputType.number,
                controller: _areaController,
              ),
            ),
            CupertinoButton(
              child: const Text('Calcular'),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/calcular_area',
                  arguments: {'raio': _areaController.text},
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CalculateAreaScreen extends StatelessWidget {
  const CalculateAreaScreen({super.key, required this.raio});
  final String raio;

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: 'Voltar',
        middle: Text('Aula 7 do Maurão'),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(raio.toString())],
      ),
    );
  }
}
