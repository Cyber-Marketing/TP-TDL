import 'package:flutter/material.dart';

class CustomInputDecoration extends InputDecoration {
  CustomInputDecoration({required this.hintText});

  @override
  final String hintText;
  final TextStyle textStyle = TextStyle(color: Colors.grey);
  @override
  final EdgeInsetsGeometry contentPadding =
      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0);
  final InputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  );
  final InputBorder enabledBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  );
  final InputBorder focusedBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  );
}
