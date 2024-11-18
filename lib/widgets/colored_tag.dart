import 'package:flutter/material.dart';

class ColoredTag extends StatelessWidget {
  const ColoredTag({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          color: Color.fromARGB(255, 236, 146, 146),
        ),
        padding: EdgeInsets.all(5),
        child: Text(
          text,
          style:
              TextStyle(color: Color.fromARGB(255, 168, 20, 20), fontSize: 12),
        ));
  }
}
