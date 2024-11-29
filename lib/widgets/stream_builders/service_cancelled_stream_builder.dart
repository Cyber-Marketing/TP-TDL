import 'package:flutter/material.dart';
import 'package:web_app/data/appointment_database.dart';
import 'package:web_app/data/service_repository.dart';
import 'package:web_app/domain/appointment.dart';
import 'package:web_app/widgets/cards/service_appointment_card.dart';
import 'package:web_app/widgets/section_title.dart';

class ServiceCancelledStreamBuilder extends StatelessWidget {
  final String userUid;
  final String? name;

  ServiceCancelledStreamBuilder({required this.userUid, this.name});

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

              var appointments = name != null
                  ? snapshot.data!.docs
                      .map((docSnapshot) {
                        var appointmentMap = docSnapshot.data();
                        appointmentMap['uid'] = docSnapshot.id;
                        return Appointment.fromMap(appointmentMap);
                      })
                      .where((app) =>
                          !app.hasEnded() &&
                          app.isCancelled == false &&
                          businessNames.contains(app.businessName) &&
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
                          businessNames.contains(app.businessName))
                      .toList();

              String sectionTitle = appointments.isEmpty
                  ? 'No te cancelaron ningún turno aún'
                  : 'Te cancelaron ${appointments.length} turno${appointments.length > 1 ? 's' : ''}:';

              return ListView(
                padding: EdgeInsets.all(30),
                children: [
                  SectionTitle(text: sectionTitle),
                  for (var appointment in appointments)
                    ServiceAppointmentCard(
                        appointment: appointment, isCancellable: false),
                ],
              );
            },
          );
        });
  }
}
