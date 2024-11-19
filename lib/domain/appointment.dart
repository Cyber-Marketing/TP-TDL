import 'package:flutter/material.dart';

class Appointment {
  Appointment(
      {required this.businessName,
      required this.serviceDescription,
      required this.category,
      required this.servicePrice,
      required this.serviceDuration});

  String businessName;
  String serviceDescription;
  String category;
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
  double servicePrice;
  Duration serviceDuration;

  Map<String, (TimeOfDay, TimeOfDay)> createSchedules() {
    Map<String, (TimeOfDay, TimeOfDay)> schedules = {};

    DateTime startTimeIterator = timeRange.start;
    TimeOfDay startTime = TimeOfDay.fromDateTime(timeRange.start);
    TimeOfDay closeTime = TimeOfDay.fromDateTime(timeRange.end);
    while (startTime.isBefore(closeTime)) {
      String schedule =
          "${startTimeIterator.hour}:${startTimeIterator.minute}hs - ";
      startTimeIterator = startTimeIterator.add(serviceDuration);
      TimeOfDay start =
          TimeOfDay(hour: startTime.hour, minute: startTime.minute);
      startTime = TimeOfDay.fromDateTime(startTimeIterator);
      if (startTime.isBefore(closeTime) ||
          startTime.isAtSameTimeAs(closeTime)) {
        schedule = "$schedule${startTime.hour}:${startTime.minute}hs";
        schedules[schedule] = (start, startTime);
      }
    }
    return schedules;
  }
}
