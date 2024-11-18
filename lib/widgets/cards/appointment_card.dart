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
          Text(
              "${appointment.businessName}\n${appointment.serviceDescription}\n${appointment.getServiceDay()}\n${appointment.getServiceTime()}\n"),
          IconButton(
              icon: Icon(Icons.cancel_outlined),
              tooltip: "Cancelar",
              color: Colors.black,
              onPressed: () async {
                await updateCustomerCancelledAppointment(
                    userUid, appointment, 0);
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
