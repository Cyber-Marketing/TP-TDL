import 'package:flutter/material.dart';

class MadeAppointment {
  String businessName;
  String serviceDescription;
  double servicePrice;
  DateTime serviceDay;
  (TimeOfDay, TimeOfDay) serviceTime;
  Duration serviceDuration;

  MadeAppointment(this.businessName, this.serviceDescription, this.servicePrice,
      this.serviceDay, this.serviceTime, this.serviceDuration);

  String getServiceDay() {
    return "${serviceDay.day}/${serviceDay.month}/${serviceDay.year}";
  }

  String getServiceTime() {
    var (startServiceTime, endServiceTime) = serviceTime;
    return "${startServiceTime.hour}:${startServiceTime.minute}hs - ${endServiceTime.hour}:${endServiceTime.minute}hs";
  }
}
