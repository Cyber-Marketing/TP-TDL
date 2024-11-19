import 'package:flutter/material.dart';
import 'package:web_app/data/appointment_database.dart';
import 'package:web_app/domain/made_appointment.dart';

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({
    super.key,
    required this.appointment,
    required this.userUid,
  });

  final MadeAppointment appointment;
  final String userUid;

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
          Text(appointment.businessName),
          Text(appointment.serviceDescription),
          Text(appointment.getServiceDay()),
          Text(appointment.getServiceTime()),
          IconButton(
              icon: Icon(Icons.cancel_outlined),
              tooltip: "Cancelar",
              color: Theme.of(context).colorScheme.inversePrimary,
              onPressed: () {
                cancelAppointment(userUid, appointment);
                if (context.mounted) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Turno cancelado')));
                }
              })
        ],
      ),
    );
  }
}
