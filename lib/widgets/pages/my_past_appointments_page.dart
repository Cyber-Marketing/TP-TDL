import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/app_state.dart';
import 'package:web_app/data/appointment_database.dart';
import 'package:web_app/domain/made_appointment.dart';

class MyPastAppointmentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String userUid = context.watch<AppState>().currentUser!.uid;

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
      future: getUserAppointments(userUid),
      builder: ((context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        var pastAppointments = snapshot.data!.docs
            .map((docSnapshot) {
              var appointmentMap = docSnapshot.data();
              appointmentMap['uid'] = docSnapshot.id;
              return MadeAppointment.fromMap(appointmentMap);
            })
            .where((app) => app.getServiceDateTime().isBefore(DateTime.now()))
            .toList();
        return myPastAppointments(pastAppointments);
      }),
    );
  }
}
