import 'package:flutter/material.dart';

class Appointment {
  String uid;
  String businessName;
  String serviceDescription;
  double servicePrice;
  DateTime serviceDay;
  (TimeOfDay, TimeOfDay) serviceTime;
  bool isCancelled;

  Appointment(this.businessName, this.serviceDescription, this.servicePrice,
      this.serviceDay, this.serviceTime,
      {this.isCancelled = false, this.uid = ''});

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

  factory Appointment.fromMap(madeAppointmentMap) {
    var instance = Appointment(
        isCancelled: madeAppointmentMap['isCancelled'],
        madeAppointmentMap['businessName'],
        madeAppointmentMap['serviceDescription'],
        madeAppointmentMap['servicePrice'],
        DateTime.parse(madeAppointmentMap['serviceDay']),
        (
          TimeOfDay(
              hour: madeAppointmentMap['serviceTime.\$1.hour'],
              minute: madeAppointmentMap['serviceTime.\$1.minute']),
          TimeOfDay(
              hour: madeAppointmentMap['serviceTime.\$2.hour'],
              minute: madeAppointmentMap['serviceTime.\$2.minute'])
        ));
    instance.uid = madeAppointmentMap['uid'];
    return instance;
  }

  Map<String, dynamic> toMap() {
    return {
      'businessName': businessName,
      'serviceDescription': serviceDescription,
      'servicePrice': servicePrice,
      'serviceDay': serviceDay.toString(),
      'serviceTime.\$1.hour': serviceTime.$1.hour,
      'serviceTime.\$1.minute': serviceTime.$1.minute,
      'serviceTime.\$2.hour': serviceTime.$2.hour,
      'serviceTime.\$2.minute': serviceTime.$2.minute,
      'isCancelled': isCancelled,
    };
  }

  bool hasEnded() {
    return getServiceDateTime().isBefore(DateTime.now());
  }
}
