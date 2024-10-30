import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../main.dart';

class MyAppointmentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    if (appState.appointments.isEmpty) {
      return ListView(children: [
        Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'No reservaste ningún turno aún',
              style: TextStyle(
                  fontSize: 30, color: const Color.fromARGB(255, 8, 63, 49)),
            ))
      ]);
    }

    int totalAppointments = appState.appointments.length;

    return ListView(
      children: [
        Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
                'Tenés $totalAppointments turno${totalAppointments > 1 ? 's' : ''}:',
                style: TextStyle(
                    fontSize: 60,
                    color: const Color.fromARGB(255, 8, 63, 49)))),
        for (var appointment in appState.appointments)
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(
                "${appointment.businessName}\n${appointment.serviceDescription}"),
          ),
      ],
    );
  }
}
