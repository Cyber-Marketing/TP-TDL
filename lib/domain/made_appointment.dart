import 'package:flutter/material.dart';

class MadeAppointment {
  String businessName;
  String serviceDescription;
  double servicePrice;
  DateTime serviceDay;
  (TimeOfDay, TimeOfDay) serviceTime;

  MadeAppointment(this.businessName, this.serviceDescription, this.servicePrice,
      this.serviceDay, this.serviceTime);

  String getServiceDay() {
    return "${serviceDay.day}/${serviceDay.month}/${serviceDay.year}";
  }

  String getServiceTime() {
    var (startServiceTime, endServiceTime) = serviceTime;
    return "${startServiceTime.hour}:${startServiceTime.minute}hs - ${endServiceTime.hour}:${endServiceTime.minute}hs";
  }

  factory MadeAppointment.fromMap(madeAppointmentMap) {
    return MadeAppointment(
        madeAppointmentMap['businessName'],
        madeAppointmentMap['serviceDescription'],
        madeAppointmentMap['servicePrice'],
        DateTime(
            madeAppointmentMap['serviceDay.year'],
            madeAppointmentMap['serviceDay.month'],
            madeAppointmentMap['serviceDay.day']),
        (
          TimeOfDay(
              hour: madeAppointmentMap['serviceTime.\$1.hour'],
              minute: madeAppointmentMap['serviceTime.\$1.minute']),
          TimeOfDay(
              hour: madeAppointmentMap['serviceTime.\$2.hour'],
              minute: madeAppointmentMap['serviceTime.\$2.minute'])
        ));
  }

  Map<String, dynamic> toMap() {
    return {
      'businessName': businessName,
      'serviceDescription': serviceDescription,
      'servicePrice': servicePrice,
      'serviceDay.year': serviceDay.year,
      'serviceDay.month': serviceDay.month,
      'serviceDay.day': serviceDay.day,
      'serviceTime.\$1.hour': serviceTime.$1.hour,
      'serviceTime.\$1.minute': serviceTime.$1.minute,
      'serviceTime.\$2.hour': serviceTime.$2.hour,
      'serviceTime.\$2.minute': serviceTime.$2.minute,
    };
  }
}
