import 'package:flutter/material.dart';
import 'package:web_app/domain/appointment.dart';

class ServiceAppointmentCard extends StatelessWidget {
  const ServiceAppointmentCard(
      {super.key,
      required this.appointment,
      this.isCancellable = true,
      this.isRateable = false});

  final Appointment appointment;
  final bool isCancellable;
  final bool isRateable;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Theme.of(context).colorScheme.inversePrimary,
      ),
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            appointment.businessName,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Row(
            children: [
              Text("- Descripcion: ", style: TextStyle(fontWeight: FontWeight.bold)),
              Text(appointment.serviceDescription)
            ],
          ),
          Row(
            children: [
              Text("- Dia del servicio: ", style: TextStyle(fontWeight: FontWeight.bold)),
              Text(appointment.getServiceDay())
            ],
          ),
          Row(
            children: [
              Text("- Horario del servicio: ", style: TextStyle(fontWeight: FontWeight.bold)),
              Text(appointment.getServiceTime())
            ],
          ),
          Row(
            children: [
              Text("- Precio del servicio: ", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("\$${appointment.servicePrice}")
            ],
          ),
          Row(
            children: [
              Text("- Reservado por: ", style: TextStyle(fontWeight: FontWeight.bold)),
              Text(appointment.userFullName)
            ],
          )
        ]
      ));
  }

}
