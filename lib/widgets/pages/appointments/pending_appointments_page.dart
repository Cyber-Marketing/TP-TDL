import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/app_state.dart';
import 'package:web_app/data/appointment_database.dart';
import 'package:web_app/domain/appointment.dart';
import 'package:web_app/widgets/cards/appointment_card.dart';
import 'package:web_app/widgets/section_title.dart';

class PendingAppointmentsPage extends StatefulWidget {
  @override
  State<PendingAppointmentsPage> createState() =>
      _PendingAppointmentsPageState();
}

class _PendingAppointmentsPageState extends State<PendingAppointmentsPage> {
  var _appointmentsStream = getAppointmentsStream();

  @override
  Widget build(BuildContext context) {
    String userUid = context.watch<AppState>().currentUser!.uid;

    return StreamBuilder(
        stream: _appointmentsStream,
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          var appointments = snapshot.data!.docs
              .map((docSnapshot) {
                var appointmentMap = docSnapshot.data();
                appointmentMap['uid'] = docSnapshot.id;
                return Appointment.fromMap(appointmentMap);
              })
              .where((app) =>
                  !app.hasEnded() &&
                  app.isCancelled == false &&
                  app.userUid == userUid)
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
        });
  }
}
