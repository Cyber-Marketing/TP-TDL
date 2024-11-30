import 'package:flutter/material.dart';
import 'package:web_app/data/appointment_database.dart';
import 'package:web_app/data/service_repository.dart';
import 'package:web_app/domain/appointment.dart';
import 'package:web_app/widgets/cards/appointed_service_card.dart';
import 'package:web_app/widgets/section_title.dart';

class PendingAppointedServicesStreamBuilder extends StatelessWidget {
  final String userUid;
  final String? name;

  PendingAppointedServicesStreamBuilder({required this.userUid, this.name});

  @override
  Widget build(BuildContext context) {
    List<String> businessNames = [];
    return StreamBuilder(
        stream: getAppointmentsStream(),
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return FutureBuilder(
            future: ServicesRepository().getBusinessNamesByUserUid(userUid),
            builder: (context, snapshotBusiness) {
              if (!snapshotBusiness.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              businessNames = snapshotBusiness.data!;

              bool Function(Appointment app) filteringCondition = name == null
                  ? (Appointment app) =>
                      !app.hasEnded() &&
                      app.isCancelled == false &&
                      businessNames.contains(app.businessName)
                  : (Appointment app) =>
                      !app.hasEnded() &&
                      app.isCancelled == false &&
                      businessNames.contains(app.businessName) &&
                      app.businessName
                          .toLowerCase()
                          .contains(name!.toLowerCase());

              var appointmentsIterable = snapshot.data!.docs.map((docSnapshot) {
                var appointmentMap = docSnapshot.data();
                appointmentMap['uid'] = docSnapshot.id;
                return Appointment.fromMap(appointmentMap);
              });

              List<Appointment> appointments =
                  appointmentsIterable.where(filteringCondition).toList();

              String pluralSuffix = appointments.length > 1 ? 's' : '';
              String sectionTitle = appointments.isEmpty
                  ? 'No te reservaron ningún turno aún'
                  : 'Tenés ${appointments.length} turno$pluralSuffix reservado$pluralSuffix por alguien:';

              return ListView(
                padding: EdgeInsets.all(30),
                children: [
                  SectionTitle(text: sectionTitle),
                  for (var appointment in appointments)
                    AppointedServiceCard(appointment: appointment)
                ],
              );
            },
          );
        });
  }
}
