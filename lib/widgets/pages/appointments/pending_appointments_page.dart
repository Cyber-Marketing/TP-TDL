import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/app_state.dart';
import 'package:web_app/data/appointment_database.dart';
import 'package:web_app/domain/made_appointment.dart';
import 'package:web_app/widgets/cards/appointment_card.dart';
import 'package:web_app/widgets/section_title.dart';

class PendingAppointmentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String userUid = context.watch<AppState>().currentUser!.uid;

    return FutureBuilder(
      future: getUserAppointments(userUid),
      builder: ((context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        var appointments = snapshot.data!.docs
            .map((docSnapshot) {
              var appointmentMap = docSnapshot.data();
              appointmentMap['uid'] = docSnapshot.id;
              return MadeAppointment.fromMap(appointmentMap);
            })
            .where((app) => !app.hasEnded())
            .toList();

        String pluralSuffix = appointments.length > 1 ? 's' : '';
        String sectionTitle = appointments.isEmpty
            ? 'No tenés ningún turno pendiente'
            : 'Tenés ${appointments.length} turno$pluralSuffix pendiente$pluralSuffix:';

        return ListView(
          padding: EdgeInsets.all(30),
          children: [
            SectionTitle(text: sectionTitle),
            for (var appointment in appointments)
              AppointmentCard(appointment: appointment, userUid: userUid)
          ],
        );
      }),
    );
  }
}