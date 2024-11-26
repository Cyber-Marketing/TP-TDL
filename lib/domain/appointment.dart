import 'package:flutter/material.dart';

class Appointment {
  String uid;
  String userUid;
  String businessName;
  String serviceDescription;
  double servicePrice;
  String userFullName;
  DateTime serviceDay;
  (TimeOfDay, TimeOfDay) serviceTime;
  bool isCancelled;
  int? rating;
  String? comment;

  Appointment(this.businessName, this.serviceDescription, this.servicePrice,
      this.userFullName, this.serviceDay, this.serviceTime,
      {this.isCancelled = false,
      this.uid = '',
      this.userUid = '',
      this.rating,
      this.comment});

  String getServiceDay() {
    return "${serviceDay.day}/${serviceDay.month}/${serviceDay.year}";
  }

  String getServiceTime() {
    var (startServiceTime, endServiceTime) = serviceTime;
    return "${startServiceTime.hour}:${startServiceTime.minute}hs - ${endServiceTime.hour}:${endServiceTime.minute}hs";
  }

  DateTime getServiceDateTime() {
    var (startServiceTime, endServiceTime) = serviceTime;
    return DateTime(
      serviceDay.year,
      serviceDay.month,
      serviceDay.day,
      endServiceTime.hour,
      endServiceTime.minute,
    );
  }

  factory Appointment.fromMap(appointmentMap) {
    return Appointment(
        userUid: appointmentMap['userUid'],
        uid: appointmentMap['uid'],
        isCancelled: appointmentMap['isCancelled'],
        rating: appointmentMap['rating'],
        comment: appointmentMap['comment'],
        appointmentMap['businessName'],
        appointmentMap['serviceDescription'],
        appointmentMap['servicePrice'],
        appointmentMap['userFullName'],
        DateTime.parse(appointmentMap['serviceDay']),
        (
          TimeOfDay(
              hour: appointmentMap['serviceTime.\$1.hour'],
              minute: appointmentMap['serviceTime.\$1.minute']),
          TimeOfDay(
              hour: appointmentMap['serviceTime.\$2.hour'],
              minute: appointmentMap['serviceTime.\$2.minute'])
        ));
  }

  Map<String, dynamic> toMap() {
    return {
      'userUid': userUid,
      'businessName': businessName,
      'serviceDescription': serviceDescription,
      'servicePrice': servicePrice,
      'userFullName': userFullName,
      'serviceDay': serviceDay.toString(),
      'serviceTime.\$1.hour': serviceTime.$1.hour,
      'serviceTime.\$1.minute': serviceTime.$1.minute,
      'serviceTime.\$2.hour': serviceTime.$2.hour,
      'serviceTime.\$2.minute': serviceTime.$2.minute,
      'isCancelled': isCancelled,
      'rating': rating,
      'comment': comment
    };
  }

  bool hasEnded() {
    return getServiceDateTime().isBefore(DateTime.now());
  }
}
