import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/app_state.dart';
import 'package:web_app/data/appointment_database.dart';
import 'package:web_app/domain/made_appointment.dart';

class MyAppointmentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

    ListView myAppointments(List<MadeAppointment> appointments) {
      if (appointments.isEmpty) {
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

      int totalAppointments = appointments.length;

      return ListView(
        children: [
          Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                  'Tenés $totalAppointments turno${totalAppointments > 1 ? 's' : ''}:',
                  style: TextStyle(
                      fontSize: 60,
                      color: const Color.fromARGB(255, 8, 63, 49)))),
          for (var appointment in appointments)
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text(
                  "${appointment.businessName}\n${appointment.serviceDescription}\n${appointment.getServiceDay()}\n${appointment.getServiceTime()}"),
            ),
        ],
      );
    }

    return FutureBuilder(
      future: getCustomerAppointment(appState.currentUser!.uid),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          List<MadeAppointment> appointments = [];
          int length = snapshot.data!.data()!.length;
          if (length > 1) {
            for (int i = 1; i < length; i++) {
              appointments.add(
                  MadeAppointment.fromMap(snapshot.data!['appointment$i']));
            }
          }
          return myAppointments(appointments);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}
