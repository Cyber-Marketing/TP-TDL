import 'package:flutter/material.dart';

class CustomInputDecoration extends InputDecoration {
  @override
  final String hintText;
  @override
  final TextStyle hintStyle;
  @override
  final EdgeInsetsGeometry contentPadding =
      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0);
  final InputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  );
  @override
  final InputBorder enabledBorder;
  @override
  final InputBorder focusedBorder;

  factory CustomInputDecoration(
      {required String hintText, required BuildContext context}) {
    Color color = Theme.of(context).colorScheme.onPrimaryContainer;
    const borderRadius = BorderRadius.all(Radius.circular(10.0));
    TextStyle hintTextStyle = TextStyle(color: color);
    InputBorder enabledBorder = OutlineInputBorder(
      borderSide: BorderSide(color: color, width: 1.0),
      borderRadius: borderRadius,
    );
    InputBorder focusedBorder = OutlineInputBorder(
      borderSide: BorderSide(color: color, width: 2.5),
      borderRadius: borderRadius,
    );
    return CustomInputDecoration._internal(
        hintText, hintTextStyle, enabledBorder, focusedBorder);
  }

  CustomInputDecoration._internal(
    this.hintText,
    this.hintStyle,
    this.enabledBorder,
    this.focusedBorder,
  );
}
