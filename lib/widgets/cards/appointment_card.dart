import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/appointment.dart';
import '../../main.dart';

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({
    super.key,
    required this.appointment,
  });

  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Container(
      color: Theme.of(context).colorScheme.inversePrimary,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Negocio: ${appointment.businessName}\nDescripcion: ${appointment.serviceDescription}\nPrecio: ${appointment.servicePrice.toStringAsFixed(2)}",
            style: TextStyle(fontSize: 20),
          ),
          IconButton(
              iconSize: 30,
              onPressed: () {
                appState.bookAppointment(appointment);
              },
              icon: const Icon(Icons.book))
        ],
      )),
    );
  }
}
