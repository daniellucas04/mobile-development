import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[400],
      appBar: AppBar(
        title: const Text('Aves'),
        backgroundColor: Colors.lightGreen[800],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(100)),
            ),
            const Text('Daniel Lucas'),
            const Text('20 anos'),
            Container(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PrimeiraPagina(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.only(left: 40, right: 40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: const Text('Coruja'),
              ),
            ),
            Container(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SegundaPagina(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.only(left: 37, right: 37),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: const Text('Rolinha'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

mixin context {}

class PrimeiraPagina extends StatelessWidget {
  const PrimeiraPagina({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[400],
      appBar: AppBar(
        title: const Text('Aves'),
        backgroundColor: Colors.lightGreen[800],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const Text('Coruja Buraqueira'),
            const Text(
              'Ave de pequeno porte, seu tamanho médio é de 21,5 a 28,5 cm (machos) e de 22 a 25 cm (fêmeas). Pesa entre 110 e 285 g (machos) e entre 150 a 265 g (fêmeas). Possui a cabeça redonda, sem penachos e os olhos estão dispostos lado a lado, num mesmo plano. As sobrancelhas são brancas e os olhos amarelos. A coloração é cor de terra, mimética, podendo apresentar plumagem em tons de ferrugem causados por solos de terra roxa (coloração adventícia).',
              textAlign: TextAlign.center,
            ),
            Container(
              color: Colors.lightBlue,
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(10),
              child: Image.network(
                'https://agron.com.br/wp-content/uploads/2025/05/Como-a-coruja-buraqueira-vive-em-grupo-2.webp',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
              child: const Text("Voltar"),
            ),
          ],
        ),
      ),
    );
  }
}

class SegundaPagina extends StatelessWidget {
  const SegundaPagina({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[400],
      appBar: AppBar(
        title: const Text('Aves'),
        backgroundColor: Colors.lightGreen[800],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const Text('Rolinha do planalto'),
            const Text(
              'Sendo uma das aves mais raras do mundo, foi “redescoberta” em 2015, sendo contabilizadas, na ocasião, aproximadamente 12 espécimes. Observada pouquíssimas vezes, a rolinha-do-planalto tinha o último registro comprovado há 74 anos e já era considerada extinta por muitos especialistas (27 anos de acordo com o trabalho acima citado - SILVA & ONIKI, 1988).',
              textAlign: TextAlign.center,
            ),
            Container(
              color: Colors.lightBlue,
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(10),
              child: Image.network(
                'https://s2-g1.glbimg.com/0RY4uEjezwuMx38zrlbnwsD2Dc4=/0x0:853x765/984x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_59edd422c0c84a879bd37670ae4f538a/internal_photos/bs/2025/z/9/s3OrRrQ4yAPJth9QAH9w/whatsapp-image-2025-04-10-at-10.15.24.jpeg',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
              child: const Text("Voltar"),
            ),
          ],
        ),
      ),
    );
  }
}
