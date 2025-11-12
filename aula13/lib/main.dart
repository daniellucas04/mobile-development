import 'dart:convert';

import 'package:aula13/model/Localizacao.dart';
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
  Localizacao loc = Localizacao();
  late String temp = '';
  late String umid = '';
  late String speed = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              const Text('Busca Local'),
              Text('Latitude: ${loc.latitude}'),
              Text('Longitude: ${loc.longitude}'),
              Text('Temperatura: ${temp == '' ? 'Não encontrado' : temp}'),
              Text('Umidade: ${umid == '' ? 'Não encontrado' : umid}'),
              Text(
                'Velocidade do vento: ${speed == '' ? 'Não encontrado' : speed}',
              ),
            ],
          ),
        ),
      ),
    );
  }

  _loadData() async {
    await loc.pegaLocalizacaoAtual();

    final uri = Uri.https("api.open-meteo.com", "/v1/forecast", {
      'latitude': loc.latitude.toString(),
      'longitude': loc.longitude.toString(),
      'current': 'temperature_2m,relative_humidity_2m,wind_speed_10m',
    });

    final response = await http.get(uri);
    Map<String, dynamic> jsonData = jsonDecode(response.body);

    setState(() {
      this.temp = jsonData['current']['temperature_2m'].toString();
      this.umid = jsonData['current']['relative_humidity_2m'].toString();
      this.speed = jsonData['current']['wind_speed_2m'].toString();
    });
  }
}
