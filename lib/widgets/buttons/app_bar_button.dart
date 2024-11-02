import 'package:flutter/material.dart';

class AppBarButton extends StatelessWidget {
  const AppBarButton(
      {super.key, required this.tooltip, required this.icon, this.onPressed});

  final String tooltip;
  final IconData icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 25),
        IconButton(tooltip: tooltip, onPressed: onPressed, icon: Icon(icon)),
      ],
    );
  }
}
