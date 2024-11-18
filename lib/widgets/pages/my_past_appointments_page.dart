import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/app_state.dart';
import 'package:web_app/data/appointment_database.dart';
import 'package:web_app/domain/made_appointment.dart';

class MyPastAppointmentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    DateTime serviceDayToday = DateTime.now();

    ListView myPastAppointments(List<MadeAppointment> pastAppointments) {
      if (pastAppointments.isEmpty) {
        return ListView(children: [
          Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'No tenés turnos anteriores aún',
                style: TextStyle(
                    fontSize: 30, color: const Color.fromARGB(255, 8, 63, 49)),
              ))
        ]);
      }

      int totalPastAppointments = pastAppointments.length;

      return ListView(
        children: [
          Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                  'Tuviste $totalPastAppointments turno${totalPastAppointments > 1 ? 's' : ''}:',
                  style: TextStyle(
                      fontSize: 60,
                      color: const Color.fromARGB(255, 8, 63, 49)))),
          for (var appointment in pastAppointments)
            ListTile(
              leading: Icon(Icons.date_range),
              title: Text(
                  "${appointment.businessName}\n${appointment.serviceDescription}\n${appointment.getServiceDay()}\n${appointment.getServiceTime()}"),
            ),
        ],
      );
    }

    return FutureBuilder(
      future: getCustomerAppointments(appState.currentUser!.uid),
      builder: ((context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        var pastAppointments = snapshot.data!.docs
            .map((appointmentDoc) {
              try {
                return MadeAppointment.fromMap(appointmentDoc.data());
              } catch (e) {
                print('Error creating appointment: $e');
                return null;
              }
            })
            .where((app) =>
                app != null &&
                app.getServiceDateTime().isBefore(serviceDayToday))
            .cast<MadeAppointment>()
            .toList();
        return myPastAppointments(pastAppointments);
      }),
    );
  }
}
