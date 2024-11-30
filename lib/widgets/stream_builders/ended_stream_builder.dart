import 'package:flutter/material.dart';
import 'package:web_app/data/appointment_database.dart';
import 'package:web_app/domain/appointment.dart';
import 'package:web_app/widgets/cards/my_appointment_card.dart';
import 'package:web_app/widgets/section_title.dart';

class EndedStreamBuilder extends StatelessWidget {
  final String userUid;
  final String? name;

  EndedStreamBuilder({required this.userUid, this.name});

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

          bool Function(Appointment app) filteringCondition = name == null
              ? (Appointment app) =>
                  app.hasEnded() &&
                  app.isCancelled == false &&
                  app.userUid == userUid
              : (Appointment app) =>
                  app.hasEnded() &&
                  app.isCancelled == false &&
                  app.userUid == userUid &&
                  app.businessName.toLowerCase().contains(name!.toLowerCase());

          var appointmentsIterable = snapshot.data!.docs.map((docSnapshot) {
            var appointmentMap = docSnapshot.data();
            appointmentMap['uid'] = docSnapshot.id;
            return Appointment.fromMap(appointmentMap);
          });

          List<Appointment> appointments =
              appointmentsIterable.where(filteringCondition).toList();

          String sectionTitle = appointments.isEmpty
              ? 'No tenés turnos terminados'
              : 'Tuviste ${appointments.length} turno${appointments.length > 1 ? 's' : ''}:';

          return ListView(
            padding: EdgeInsets.all(30),
            children: [
              SectionTitle(text: sectionTitle),
              for (var appointment in appointments)
                MyAppointmentCard(appointment: appointment)
            ],
          );
        });
  }
}
