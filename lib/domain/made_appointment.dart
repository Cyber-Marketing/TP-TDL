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
}
