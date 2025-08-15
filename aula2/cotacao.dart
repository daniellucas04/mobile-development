import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// Função assíncrona para buscar um post na API
Future<String> buscaCotacao() async {
  DateTime ontem = DateTime.now().subtract(const Duration(days: 1));

  String doisDigitosMes = (ontem.month.toString().length == 1)
      ? "0${ontem.month}"
      : ontem.month.toString();
  String doisDigitosDia = (ontem.day.toString().length == 1)
      ? "0${ontem.day}"
      : ontem.day.toString();

  String ontemFormatado = "${doisDigitosDia}-${doisDigitosMes}-${ontem.year}";
  // URL da API que será acessada
  var url = Uri.https(
    'olinda.bcb.gov.br',
    '/olinda/servico/PTAX/versao/v1/odata/CotacaoDolarDia(dataCotacao=@dataCotacao)',
    {
      '@dataCotacao': "'$ontemFormatado'",
      'top': "'100'",
      'format': "'json'",
      'select': "'cotacaoCompra'",
    },
  );

  try {
    // 2. Faz a requisição GET e espera a resposta
    var response = await http.get(url);

    // 3. Verifica se a requisição foi bem-sucedida
    if (response.statusCode == 200) {
      // 4. Decodifica o JSON da resposta
      var jsonBody = json.decode(response.body);

      // 5. Extrai e imprime o valor que queremos
      var cotacao = jsonBody['value'][0]['cotacaoCompra'];
      return 'Cotação de ontem ($ontemFormatado): ${cotacao.toString()}';
    } else {
      return 'Erro ao acessar a API. Status Code: ${response.statusCode}';
    }
  } catch (e) {
    // 6. Trata possíveis erros de conexão
    return 'Ocorreu um erro na requisição: $e';
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder(
          future: buscaCotacao(),
          builder: (context, snapshot) {
            final cotacao = snapshot.data!;
            return Center(child: Text(cotacao));
          },
        ),
      ),
    );
  }
}
