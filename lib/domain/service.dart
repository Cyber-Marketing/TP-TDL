import 'package:flutter/material.dart';

class Service {
  String uid;
  String ownerUid;
  String businessName;
  String description;
  String category;
  double duration;
  double price;
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

  Service(
      {this.uid = '',
      required this.ownerUid,
      required this.businessName,
      required this.description,
      required this.category,
      required this.duration,
      required this.price});

  factory Service.fromMap(serviceMap) {
    return Service(
      uid: serviceMap["uid"] ?? '',
      ownerUid: serviceMap["ownerUid"],
      businessName: serviceMap["businessName"],
      description: serviceMap["description"],
      category: serviceMap["category"],
      duration: serviceMap["duration"],
      price: serviceMap["price"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ownerUid': ownerUid,
      'businessName': businessName,
      'description': description,
      'category': category,
      'duration': duration,
      'price': price,
    };
  }

  Duration getDuration() {
    return Duration(hours: duration ~/ 60, minutes: duration.round() % 60);
  }

  Map<String, (TimeOfDay, TimeOfDay)> createSchedules() {
    Map<String, (TimeOfDay, TimeOfDay)> schedules = {};

    DateTime startTimeIterator = timeRange.start;
    TimeOfDay startTime = TimeOfDay.fromDateTime(timeRange.start);
    TimeOfDay closeTime = TimeOfDay.fromDateTime(timeRange.end);
    while (startTime.isBefore(closeTime)) {
      String schedule =
          "${startTimeIterator.hour}:${startTimeIterator.minute}hs - ";
      startTimeIterator = startTimeIterator.add(getDuration());
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
