import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:web_app/domain/made_appointment.dart';

FirebaseFirestore database = FirebaseFirestore.instance;

Future<void> addCustomerAppointment(String userUid) async {
  await database.collection('appointments').doc(userUid).set({'user': userUid});
  await database.collection('cancelled').doc(userUid).set({'user': userUid});
}

Future<QuerySnapshot<Map<String, dynamic>>> getUserAppointments(
    String userUid) async {
  return await database
      .collection('users')
      .doc(userUid)
      .collection('appointments')
      .where('isCancelled', isEqualTo: false)
      .get();
}

Future<QuerySnapshot<Map<String, dynamic>>> getUserCancelledAppointments(
    String userUid) async {
  return await database
      .collection('users')
      .doc(userUid)
      .collection('appointments')
      .where('isCancelled', isEqualTo: true)
      .get();
}

Future<void> updateCustomerAppointment(
    String user, MadeAppointment appointment, String appointmentName) async {
  await database
      .collection('appointments')
      .doc(user)
      .update({appointmentName: appointment.toMap()});
}

Future<void> cancelAppointment(
    String userUid, MadeAppointment appointment) async {
  await database
      .collection('users')
      .doc(userUid)
      .collection('appointments')
      .doc(appointment.uid)
      .update({"isCancelled": true});
  // await database
  //     .collection('cancelled')
  //     .doc(user)
  //     .update({'cancelled$number': appointment.toMap()});
  // await database
  //     .collection('appointments')
  //     .doc(user)
  //     .update({appointment.appointmentName: FieldValue.delete()});
}
