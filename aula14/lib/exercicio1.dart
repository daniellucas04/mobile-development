import 'dart:convert';
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
  final TextEditingController cityController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool loading = false;
  late String temp = '';
  late String umid = '';
  late String speed = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Clima 🌧'),
          centerTitle: true,
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            spacing: 20,
            children: [
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Container(
                  margin: EdgeInsets.all(24),
                  child: Column(
                    spacing: 20,
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value == '' || value!.isEmpty) {
                            return 'Digite o nome da cidade';
                          }

                          return null;
                        },
                        controller: cityController,
                        decoration: InputDecoration(
                          hintText: 'Cidade',
                          icon: Icon(Icons.location_city),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                      FilledButton.icon(
                        style: ButtonStyle(
                          textStyle: WidgetStatePropertyAll(
                            TextStyle(fontWeight: FontWeight.w500),
                          ),
                          iconSize: WidgetStatePropertyAll(16),
                          visualDensity: VisualDensity(horizontal: 4),
                        ),
                        onPressed: () {
                          setState(() {
                            loading = true;
                          });
                          if (!cityController.text.isEmpty) {
                            getWeatherInfo();
                          }
                        },
                        label: Text('Buscar'),
                        icon: Icon(Icons.search),
                      ),
                    ],
                  ),
                ),
              ),
              loading
                  ? CircularProgressIndicator()
                  : Container(
                      margin: EdgeInsets.all(24),
                      child: Column(
                        spacing: 14,
                        children: [
                          Card(
                            elevation: 1,
                            child: Container(
                              padding: EdgeInsets.all(24),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Temperatura',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(temp),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            elevation: 1,
                            child: Container(
                              padding: EdgeInsets.all(24),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Umidade',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(umid),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            elevation: 1,
                            child: Container(
                              padding: EdgeInsets.all(24),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Vel. Vento',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    speed.isEmpty || speed == 'null'
                                        ? 'Não encontrado'
                                        : speed,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  getWeatherInfo() async {
    final baseCityUrl =
        Uri.https('geocoding-api.open-meteo.com', '/v1/search', {
          'name': removerAcentos(cityController.text.toLowerCase()),
          'format': 'json',
          'count': '1',
          'language': 'en',
        });

    final cityResponse = await http.get(baseCityUrl);
    Map<String, dynamic> cityData = jsonDecode(cityResponse.body);

    final latitude = cityData['results'][0]['latitude'].toString();
    final longitude = cityData['results'][0]['longitude'].toString();

    final uri = Uri.https("api.open-meteo.com", "/v1/forecast", {
      'latitude': latitude,
      'longitude': longitude,
      'current': 'temperature_2m,relative_humidity_2m,wind_speed_10m',
      'countryCode': 'BR',
    });

    final weatherResponse = await http.get(uri);
    Map<String, dynamic> weatherData = jsonDecode(weatherResponse.body);

    setState(() {
      this.temp = weatherData['current']['temperature_2m'].toString();
      this.umid = weatherData['current']['relative_humidity_2m'].toString();
      this.speed = weatherData['current']['wind_speed_2m'].toString();
      loading = false;
    });
  }

  String removerAcentos(String str) {
    var comAcento =
        'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
    var semAcento =
        'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz';

    for (int i = 0; i < comAcento.length; i++) {
      str = str.replaceAll(comAcento[i], semAcento[i]);
    }

    return str;
  }
}
