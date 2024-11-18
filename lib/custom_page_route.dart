import 'package:flutter/material.dart';

class CustomPageRoute extends MaterialPageRoute {
  CustomPageRoute({pageWidget}) : super(builder: (context) => pageWidget);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);

  @override
  Duration get reverseTransitionDuration => const Duration(milliseconds: 0);
}
