import 'package:flutter/material.dart';

class BotaoRedondo extends StatelessWidget {
  BotaoRedondo({
    required this.icone,
    required this.function,
    required this.text,
  });

  final IconData icone;
  final Function function;
  final String text;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 0,
      highlightElevation: 0,
      onPressed: () => function(),
      constraints: BoxConstraints.tightFor(width: 100),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.all(Radius.circular(8)),
      ),
      fillColor: Color.fromARGB(255, 231, 42, 42),
      padding: EdgeInsetsGeometry.all(10),
      child: Row(
        spacing: 8,
        children: [
          Icon(icone, color: Colors.white),
          Text(text, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
