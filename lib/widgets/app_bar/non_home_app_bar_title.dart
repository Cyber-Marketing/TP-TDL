import 'package:flutter/material.dart';

class NonHomeAppBarTitle extends StatelessWidget {
  const NonHomeAppBarTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: const TextStyle(color: Colors.white, fontSize: 25));
  }
}
