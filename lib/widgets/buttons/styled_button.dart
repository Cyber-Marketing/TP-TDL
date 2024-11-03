import 'package:flutter/material.dart';

class StyledButton extends StatelessWidget {
  const StyledButton({required this.text, required this.onPressed, super.key});
  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          side: BorderSide(color: Theme.of(context).colorScheme.surfaceBright)),
      onPressed: onPressed,
      child: Text(text,
          style: TextStyle(color: Theme.of(context).colorScheme.surfaceBright)),
    );
  }
}
