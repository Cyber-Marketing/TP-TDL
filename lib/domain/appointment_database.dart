import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:web_app/domain/made_appointment.dart';

List encodingMadeAppointment(List<MadeAppointment> appointments) {
  List encodingList = [];
  for (var appointment in appointments) {
    encodingList.add([
      appointment.businessName,
      appointment.serviceDescription,
      appointment.servicePrice,
      appointment.serviceDay.year,
      appointment.serviceDay.month,
      appointment.serviceDay.day,
      appointment.serviceTime.$1.hour,
      appointment.serviceTime.$1.minute,
      appointment.serviceTime.$2.hour,
      appointment.serviceTime.$2.minute,
    ]);
  }
  return encodingList;
}

List<MadeAppointment> decodingMadeAppointment(List appointments) {
  List<MadeAppointment> decodingList = [];
  for (var appointment in appointments) {
    decodingList.add(MadeAppointment(
        appointment[0],
        appointment[1],
        appointment[2],
        DateTime(appointment[3], appointment[4], appointment[5]), (
      TimeOfDay(hour: appointment[6], minute: appointment[7]),
      TimeOfDay(hour: appointment[8], minute: appointment[9])
    )));
  }
  return decodingList;
}

FirebaseFirestore database = FirebaseFirestore.instance;

Future<void> addCustomerAppointment(String user) async {
  await database.collection('data').doc(user).set({'user': user});
}

Future<QuerySnapshot<Map<String, dynamic>>> getCustomerAppointment(
    String user) async {
  return await database.collection('data').where('user', isEqualTo: user).get();
}

Future<void> updateCustomerAppointment(String user, List appointments) async {
  await database
      .collection('data')
      .doc(user)
      .set({'appointments': appointments});
}
