import 'dart:math';
import 'package:flutter/material.dart';
import 'package:random_name_generator/random_name_generator.dart';

class Appointment {
  Appointment();

  var businessName = RandomNames(Zone.spain).name();
  var serviceDescription = RandomNames(Zone.spain).surname();
  DateTimeRange timeRange = DateTimeRange(
    start: DateTime(
      2024,
      1,
      30,
      10,
    ),
    end: DateTime(
      2024,
      1,
      30,
      10,
    ),
  );
  double servicePrice = Random().nextDouble() * 100;
}
