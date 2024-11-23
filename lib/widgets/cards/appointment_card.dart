import 'package:flutter/material.dart';
import 'package:web_app/data/appointment_database.dart';
import 'package:web_app/domain/appointment.dart';

class AppointmentCard extends StatelessWidget {
  const AppointmentCard(
      {super.key,
      required this.appointment,
      required this.userUid,
      this.isCancellable = true,
      this.isRateable = false});

  final Appointment appointment;
  final String userUid;
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
          Text(appointment.businessName),
          Text(appointment.serviceDescription),
          Text(appointment.getServiceDay()),
          Text(appointment.getServiceTime()),
          Visibility(
            visible: isCancellable,
            child: IconButton(
              icon: Icon(Icons.disabled_by_default),
              tooltip: "Cancelar",
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text('¿Seguro querés cancelar el turno?'),
                  actions: [
                    TextButton(
                      child: Text('No'),
                      onPressed: () => Navigator.pop(context),
                    ),
                    TextButton(
                      child: Text('Sí'),
                      onPressed: () {
                        cancelAppointment(appointment);
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Turno cancelado')));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: isRateable,
            child: IconButton(
              icon: Icon(Icons.grade_outlined),
              tooltip: "Calificar",
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text('¿Qué nota le das al servicio recibido?'),
                  actions: [
                    TextButton(
                      child: Text('Cancelar'),
                      onPressed: () => Navigator.pop(context),
                    ),
                    TextButton(
                      child: Text('Enviar'),
                      onPressed: () {
                        rateAppointment(userUid, appointment, 5);
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Turno calificado exitosamente')));
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
