import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:web_app/domain/appointment.dart';

FirebaseFirestore database = FirebaseFirestore.instance;

Stream<QuerySnapshot<Map<String, dynamic>>> getUserAppointmentsStream(userUid) {
  return database
      .collection('appointments')
      .where('userUid', isEqualTo: userUid)
      .snapshots();
}

Future<QuerySnapshot<Map<String, dynamic>>> getUserAppointments(
    String userUid) async {
  return await database
      .collection('appointments')
      .where('userUid', isEqualTo: userUid)
      .where('isCancelled', isEqualTo: false)
      .get();
}

Future<QuerySnapshot<Map<String, dynamic>>> getUserCancelledAppointments(
    String userUid) async {
  return await database
      .collection('appointments')
      .where('userUid', isEqualTo: userUid)
      .where('isCancelled', isEqualTo: true)
      .get();
}

Future<void> cancelAppointment(Appointment appointment) async {
  await database
      .collection('appointments')
      .doc(appointment.uid)
      .update({"isCancelled": true});
}

makeAppointment(String userUid, Appointment newAppointment) async {
  bool needToAddNew = true;
  var query = database
      .collection('appointments')
      .where('userUid', isEqualTo: userUid)
      .where('businessName', isEqualTo: newAppointment.businessName)
      .where('serviceDay', isEqualTo: newAppointment.serviceDay.toString());
  await query.get().then((snapshot) async {
    for (var snapshotDoc in snapshot.docs) {
      var appointmentMap = snapshotDoc.data();
      appointmentMap['uid'] = snapshotDoc.id;
      Appointment old = Appointment.fromMap(appointmentMap);
      if (old.serviceTime.$1.isAtSameTimeAs(newAppointment.serviceTime.$1) &&
            old.serviceTime.$2.isAtSameTimeAs(newAppointment.serviceTime.$2) &&
            old.isCancelled) {
          await snapshotDoc.reference.update({'isCancelled': false});
          needToAddNew = false;
          break;
      }}});
    if(needToAddNew) {
      newAppointment.userUid = userUid;
      var appointmentMap = newAppointment.toMap();
      await database.collection("appointments").add(appointmentMap);
    }
}

Future<List<String>> getFreeAppointments(
    Map<String, (TimeOfDay, TimeOfDay)> completeSchedules,
    String businessName,
    DateTime serviceDay, DateTime rightNow) async {
  List<String> freeAppointments = [];
  Map<String, (TimeOfDay, TimeOfDay)> newSchedules = Map.from(completeSchedules); 
  var query = database
      .collection('appointments')
      .where('businessName', isEqualTo: businessName)
      .where('serviceDay', isEqualTo: serviceDay.toString());
  return await query.get().then((snapshot) {
    for (var snapshotDoc in snapshot.docs) {
      var appointmentMap = snapshotDoc.data();
      appointmentMap['uid'] = snapshotDoc.id;
      Appointment app = Appointment.fromMap(appointmentMap);
      for (var times in completeSchedules.entries) {
        var (startTime, endTime) = times.value;
        if (app.serviceTime.$1.isAtSameTimeAs(startTime) &&
            app.serviceTime.$2.isAtSameTimeAs(endTime) &&
            !app.isCancelled) {
          newSchedules.remove(times.key);
          break;
        }
        else if ((serviceDay.day < rightNow.day &&
            serviceDay.month < rightNow.month &&
            serviceDay.year < rightNow.year) || 
            (serviceDay.day == rightNow.day &&
            serviceDay.month == rightNow.month &&
            serviceDay.year == rightNow.year &&
            startTime.isBefore(TimeOfDay(hour: rightNow.hour,
            minute:rightNow.minute)))) {
          newSchedules.remove(times.key);
        }
      }
    }
    if (newSchedules.isNotEmpty) {
      freeAppointments = newSchedules.keys.toList();
    }
    freeAppointments.add("Elegí una opción");
    return freeAppointments;
  });
}

Future<void> giveAppointmentFeedback(
    String appointmentUid, int rating, String? comment) async {
  await database
      .collection('appointments')
      .doc(appointmentUid)
      .update({"rating": rating, "comment": comment});
}

Stream<QuerySnapshot<Map<String, dynamic>>> getAppointmentsStream() {
  return database.collection('appointments').snapshots();
}

Future<QuerySnapshot<Map<String, dynamic>>> getAppointmentsByBusinessName(String businessName) async {
  return await database.collection('appointments')
      .where('businessName', isEqualTo: businessName)
      .get();
}
