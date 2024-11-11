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

  Map<String, (TimeOfDay, TimeOfDay)> createSchedules() {
    Map<String, (TimeOfDay, TimeOfDay)> schedules = {};
    DateTime service = timeRange.start;
    TimeOfDay serviceTime =
        TimeOfDay(hour: timeRange.start.hour, minute: timeRange.start.minute);
    TimeOfDay close =
        TimeOfDay(hour: timeRange.end.hour, minute: timeRange.end.minute);
    while (serviceTime.isBefore(close)) {
      String schedule = "${service.hour}:${service.minute}hs - ";
      service = service.add(serviceDuration);
      TimeOfDay start =
          TimeOfDay(hour: serviceTime.hour, minute: serviceTime.minute);
      serviceTime = TimeOfDay(hour: service.hour, minute: service.minute);
      if (serviceTime.isBefore(close) || serviceTime == close) {
        schedule = "$schedule${serviceTime.hour}:${serviceTime.minute}hs";
        schedules[schedule] = (start, serviceTime);
      }
    }
    return schedules;
  }
}
