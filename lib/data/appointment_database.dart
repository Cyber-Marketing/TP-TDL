import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore database = FirebaseFirestore.instance;

Future<void> addCustomerAppointment(String userUid) async {
  await database.collection('data').doc(userUid).set({'user': userUid});
}

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
