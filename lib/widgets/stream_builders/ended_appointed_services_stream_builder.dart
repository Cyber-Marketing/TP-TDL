import 'package:flutter/material.dart';
import 'package:web_app/data/appointment_database.dart';
import 'package:web_app/data/service_repository.dart';
import 'package:web_app/domain/appointment.dart';
import 'package:web_app/widgets/cards/appointed_service_card.dart';
import 'package:web_app/widgets/section_title.dart';

class EndedAppointedServicesStreamBuilder extends StatelessWidget {
  final String userUid;
  final String? name;

  EndedAppointedServicesStreamBuilder({required this.userUid, this.name});

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
                      app.hasEnded() &&
                      app.isCancelled == false &&
                      businessNames.contains(app.businessName)
                  : (Appointment app) =>
                      app.hasEnded() &&
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

              String sectionTitle = appointments.isEmpty
                  ? 'Ningún turno ha terminado aún'
                  : '${appointments.length} turno${appointments.length > 1 ? 's' : ''} terminado${appointments.length > 1 ? 's' : ''}:';

              return ListView(
                padding: EdgeInsets.all(30),
                children: [
                  SectionTitle(text: sectionTitle),
                  for (var appointment in appointments)
                    AppointedServiceCard(
                        appointment: appointment, isCancellable: false),
                ],
              );
            },
          );
        });
  }
}
