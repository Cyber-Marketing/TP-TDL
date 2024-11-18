import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/app_state.dart';
import 'package:web_app/data/appointment_database.dart';
import 'package:web_app/domain/made_appointment.dart';

class MyCancelledAppointmentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

    ListView myCancelledAppointments(List<MadeAppointment> cancelledAppointments) {
      if (cancelledAppointments.isEmpty) {
        return ListView(children: [
          Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'No cancelaste ningún turno aún',
                style: TextStyle(
                    fontSize: 30, color: const Color.fromARGB(255, 8, 63, 49)),
              ))
        ]);
      }

      int totalCancelledAppointments = cancelledAppointments.length;

      return ListView(
        children: [
          Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                  'Cancelaste $totalCancelledAppointments turno${totalCancelledAppointments > 1 ? 's' : ''} :',
                  style: TextStyle(
                      fontSize: 60,
                      color: const Color.fromARGB(255, 8, 63, 49)))),
          for (var appointment in cancelledAppointments)
            ListTile(
              leading: Icon(Icons.delete_forever),
              title: Text(
                  "${appointment.businessName}\n${appointment.serviceDescription}\n${appointment.getServiceDay()}\n${appointment.getServiceTime()}"),
            ),
        ],
      );
    }

    return FutureBuilder(
      future: getCustomerCancelled(appState.currentUser!.uid),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          List<MadeAppointment> cancelledAppointments = [];
          int length = snapshot.data!.data()!.length;
          if (length > 1) {
            for (int i = 1; i < length; i++) {
              cancelledAppointments.add(
                  MadeAppointment.fromMap(snapshot.data!['cancelled$i']));
            }
          }
          return myCancelledAppointments(cancelledAppointments);
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}
