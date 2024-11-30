import 'package:flutter/material.dart';
import 'package:web_app/data/appointment_database.dart';
import 'package:web_app/domain/appointment.dart';
import 'package:web_app/widgets/cards/my_appointment_card.dart';
import 'package:web_app/widgets/section_title.dart';

class CancelledStreamBuilder extends StatelessWidget {
  final String userUid;
  final String? name;

  CancelledStreamBuilder({required this.userUid, this.name});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: getAppointmentsStream(),
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          var appointments = name != null
              ? snapshot.data!.docs
                  .map((docSnapshot) {
                    var appointmentMap = docSnapshot.data();
                    appointmentMap['uid'] = docSnapshot.id;
                    return Appointment.fromMap(appointmentMap);
                  })
                  .where((app) =>
                      app.getServiceDateTime().isAfter(DateTime.now()) &&
                      app.isCancelled == true &&
                      app.userUid == userUid &&
                      app.businessName
                          .toLowerCase()
                          .contains(name!.toLowerCase()))
                  .toList()
              : snapshot.data!.docs
                  .map((docSnapshot) {
                    var appointmentMap = docSnapshot.data();
                    appointmentMap['uid'] = docSnapshot.id;
                    return Appointment.fromMap(appointmentMap);
                  })
                  .where((app) =>
                      app.getServiceDateTime().isAfter(DateTime.now()) &&
                      app.isCancelled == true &&
                      app.userUid == userUid)
                  .toList();

          String sectionTitle = appointments.isEmpty
              ? 'No cancelaste ningún turno aún'
              : 'Cancelaste ${appointments.length} turno${appointments.length > 1 ? 's' : ''} :';

          return ListView(
            padding: EdgeInsets.all(30),
            children: [
              SectionTitle(text: sectionTitle),
              for (var appointment in appointments)
                MyAppointmentCard(
                    appointment: appointment, isCancellable: false),
            ],
          );
        });
  }
}
