import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/app_state.dart';
import 'package:web_app/data/appointment_database.dart';
import 'package:web_app/data/service_repository.dart';
import 'package:web_app/domain/appointment.dart';
import 'package:web_app/widgets/cards/service_appointment_card.dart';
import 'package:web_app/widgets/section_title.dart';

class ServicePendingAppointmentsPage extends StatefulWidget {
  @override
  State<ServicePendingAppointmentsPage> createState() =>
      _ServicePendingAppointmentsPageState();
}

class _ServicePendingAppointmentsPageState extends State<ServicePendingAppointmentsPage> {
  var _appointmentsStream = getAppointmentsStream();
  List<String> businessNames = [];

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
          return FutureBuilder(
              future: ServicesRepository().getBusinessNamesByUserUid(userUid),
              builder: (context, snapshotBusiness) {
                if (!snapshotBusiness.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                businessNames = snapshotBusiness.data!;

                var appointments = snapshot.data!.docs
                    .map((docSnapshot) {
                      var appointmentMap = docSnapshot.data();
                      appointmentMap['uid'] = docSnapshot.id;
                      return Appointment.fromMap(appointmentMap);
                    })
                    .where((app) =>
                        !app.hasEnded() &&
                        app.isCancelled == false &&
                        businessNames.contains(app.businessName))
                    .toList();

                String pluralSuffix = appointments.length > 1 ? 's' : '';
                String sectionTitle = appointments.isEmpty
                    ? 'No te reservaron ningún turno aún'
                    : 'Tenés ${appointments.length} turno$pluralSuffix reservado$pluralSuffix por alguien:';

                return ListView(
                  padding: EdgeInsets.all(30),
                  children: [
                    SectionTitle(text: sectionTitle),
                    for (var appointment in appointments)
                      ServiceAppointmentCard(appointment: appointment)
                  ],
                );
              },
            );
        });
  }
}
