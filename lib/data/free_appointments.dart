import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:web_app/domain/made_appointment.dart';

FirebaseFirestore database = FirebaseFirestore.instance;

Future<List<String>> getFreeAppointments(
    Map<String, (TimeOfDay, TimeOfDay)> completeSchedules,
    String businessName,
    int serviceDay) async {
  var data = await database.collection('appointments').get();
  List<String> freeAppointments = [];
  if (data.docs.isEmpty) {
    return freeAppointments;
  }
  for (var doc in data.docs) {
    int length = doc.data().length;
    if (length > 1) {
      for (int i = 1; i < length; i++) {
        if (doc['appointment$i']['businessName'] == businessName &&
            doc['appointment$i']['serviceDay.day'] == serviceDay) {
          for (var times in completeSchedules.entries) {
            TimeOfDay startTime = times.value.$1;
            TimeOfDay endTime = times.value.$2;
            MadeAppointment app = MadeAppointment.fromMap(doc['appointment$i']);
            if (app.serviceTime.$1.isAtSameTimeAs(startTime) &&
                app.serviceTime.$2.isAtSameTimeAs(endTime)) {
              completeSchedules.remove(times.key);
              break;
            }
          }
        }
      }
    }
  }
  freeAppointments = completeSchedules.keys.toList();
  freeAppointments.add("Elegí una opción");
  return freeAppointments;
}
