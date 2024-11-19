import 'package:flutter/material.dart';
import 'package:web_app/data/appointment_database.dart';
import 'package:web_app/domain/made_appointment.dart';

class AppointmentCard extends StatelessWidget {
  const AppointmentCard(
      {super.key,
      required this.appointment,
      required this.userUid,
      this.isCancellable = true});

  final MadeAppointment appointment;
  final String userUid;
  final bool isCancellable;

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
          isCancellable
              ? IconButton(
                  icon: Icon(Icons.disabled_by_default),
                  tooltip: "Cancelar",
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Text('¿Seguro querés cancelar el turno?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('No'),
                        ),
                        TextButton(
                          onPressed: () {
                            cancelAppointment(userUid, appointment);
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Turno cancelado')));
                          },
                          child: Text('Sí'),
                        ),
                      ],
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
