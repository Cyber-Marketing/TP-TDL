import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:web_app/domain/made_appointment.dart';

List<MadeAppointment> decodingMadeAppointment(
    DocumentSnapshot<Map<String, dynamic>> appointments) {
  List<MadeAppointment> decodingList = [];
  int length = appointments.data()!.length;
  if (length > 1) {
    for (int i = 1; i < length; i++) {
      var appointment = appointments['appointment$i'];
      decodingList.add(MadeAppointment(
          appointment['businessName'],
          appointment['serviceDescription'],
          appointment['servicePrice'],
          DateTime(appointment['serviceDay.year'],
              appointment['serviceDay.month'], appointment['serviceDay.day']),
          (
            TimeOfDay(
                hour: appointment['serviceTime.\$1.hour'],
                minute: appointment['serviceTime.\$1.minute']),
            TimeOfDay(
                hour: appointment['serviceTime.\$2.hour'],
                minute: appointment['serviceTime.\$2.minute'])
          )));
    }
  }
  return decodingList;
}

FirebaseFirestore database = FirebaseFirestore.instance;

Future<DocumentSnapshot<Map<String, dynamic>>> getCustomerAppointment(
    String userUid) async {
  return await database.collection('data').doc(userUid).get();
}

Future<void> updateCustomerAppointment(
    String user, Map<String, dynamic> appointment, int number) async {
  await database
      .collection('data')
      .doc(user)
      .update({'appointment$number': appointment});
}
