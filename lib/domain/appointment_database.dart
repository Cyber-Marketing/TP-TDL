import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:web_app/domain/made_appointment.dart';

Map<String, dynamic> encodingMadeAppointment(MadeAppointment appointment) {
  return {
    'businessName': appointment.businessName,
    'serviceDescription': appointment.serviceDescription,
    'servicePrice': appointment.servicePrice,
    'serviceDay.year': appointment.serviceDay.year,
    'serviceDay.month': appointment.serviceDay.month,
    'serviceDay.day': appointment.serviceDay.day,
    'serviceTime.\$1.hour': appointment.serviceTime.$1.hour,
    'serviceTime.\$1.minute': appointment.serviceTime.$1.minute,
    'serviceTime.\$2.hour': appointment.serviceTime.$2.hour,
    'serviceTime.\$2.minute': appointment.serviceTime.$2.minute,
  };
}

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

Future<void> addCustomerAppointment(String user) async {
  await database.collection('data').doc(user).set({'user': user});
}

Future<DocumentSnapshot<Map<String, dynamic>>> getCustomerAppointment(
    String user) async {
  return await database.collection('data').doc(user).get();
}

Future<void> updateCustomerAppointment(
    String user, Map<String, dynamic> appointment, int number) async {
  await database
      .collection('data')
      .doc(user)
      .update({'appointment$number': appointment});
}
