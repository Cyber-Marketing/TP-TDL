import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:web_app/domain/made_appointment.dart';

FirebaseFirestore database = FirebaseFirestore.instance;

Future<void> addCustomerAppointment(String userUid) async {
  await database.collection('appointments').doc(userUid).set({'user': userUid});
  await database.collection('cancelled').doc(userUid).set({'user': userUid});
}

Future<DocumentSnapshot<Map<String, dynamic>>> getCustomerAppointment(
    String userUid) async {
  return await database.collection('appointments').doc(userUid).get();
}

Future<DocumentSnapshot<Map<String, dynamic>>> getCustomerCancelled(
    String userUid) async {
  return await database.collection('cancelled').doc(userUid).get();
}

Future<void> updateCustomerAppointment(
    String user, MadeAppointment appointment, String appointmentName) async {
  await database
      .collection('appointments')
      .doc(user)
      .update({appointmentName: appointment.toMap()});
}

Future<void> updateCustomerCancelledAppointment(
    String user, MadeAppointment appointment, int number) async {
  await database
      .collection('cancelled')
      .doc(user)
      .update({'cancelled$number': appointment});
  await database
      .collection('appointments')
      .doc(user)
      .update({appointment.appointmentName: FieldValue.delete()});
}
