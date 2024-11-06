import 'dart:math';
import 'package:flutter/material.dart';
import 'package:random_name_generator/random_name_generator.dart';

class Appointment {
  Appointment();

  var businessName = RandomNames(Zone.spain).name();
  var serviceDescription = RandomNames(Zone.spain).surname();
  DateTimeRange timeRange = DateTimeRange(
    start: DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      8,
    ),
    end: DateTime(
      DateTime.now().year,
      DateTime.now().month + 1,
      DateTime.now().day,
      20,
    ),
  );
  double servicePrice = Random().nextDouble() * 100;
  Duration serviceDuration = Duration(hours: 1, minutes: 30);
  Map<String, bool> schedules = {};

  void setSchedules() {
    DateTime lastTurn = timeRange.start;
    TimeOfDay timeLastTurn =
        TimeOfDay(hour: lastTurn.hour, minute: lastTurn.minute);
    TimeOfDay close =
        TimeOfDay(hour: timeRange.end.hour, minute: timeRange.end.minute);
    while (timeLastTurn.isBefore(close)) {
      String schedule = "${lastTurn.hour}:${lastTurn.minute}hs - ";
      lastTurn = lastTurn.add(serviceDuration);
      timeLastTurn = TimeOfDay(hour: lastTurn.hour, minute: lastTurn.minute);
      if (timeLastTurn.isBefore(close) || timeLastTurn == close) {
        schedule = "$schedule${timeLastTurn.hour}:${timeLastTurn.minute}hs";
        schedules[schedule] = true;
      }
    }
  }
}
