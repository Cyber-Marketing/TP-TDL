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
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
        padding: EdgeInsets.all(5),
        child: Text(
          text,
          style: TextStyle(
              color: Theme.of(context).colorScheme.onError, fontSize: 12),
        ));
  }
}
