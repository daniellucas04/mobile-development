import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

ListTile criaLinha(String title, String subtitle, Icon? icon) {
  return ListTile(
    title: Text(title, style: GoogleFonts.rampartOne(fontSize: 20)),
    subtitle: Text(
      subtitle,
      style: GoogleFonts.quicksand(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
      ),
    ),
    leading: icon,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Flash cards',
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
          backgroundColor: Colors.deepPurpleAccent[200],
          foregroundColor: Colors.white,
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.all(20),
          child: Column(
            spacing: 16,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Card(
                child: Column(
                  children: [
                    ListTile(
                      title: Text('I Coded'),
                      leading: Icon(Icons.history),
                    ),
                    Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTjMPdhc4LdFg0n6IZEk5dxPM4lTQjlAGqnHg&s',
                      scale: 2,
                    ),
                  ],
                ),
              ),
              SizedBox(child: Divider(color: Colors.black54)),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      title: Text('Im Coding'),
                      leading: Icon(Icons.wb_sunny),
                    ),
                    Image.network(
                      'https://tipscode.com.br/uploads/2020/01/js.png',
                      scale: 2,
                    ),
                  ],
                ),
              ),
              SizedBox(child: Divider(color: Colors.black54)),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      title: Text('I will Code'),
                      leading: Icon(Icons.event),
                    ),
                    Image.network(
                      'https://storage.googleapis.com/medium-feed.appspot.com/images%2F9353691196%2Ff5802bccf27a3-Para-que-e-usado-o-Golang-Usos-e-aplicacoes-comuns.jpg',
                      scale: 10,
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
}
