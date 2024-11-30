import 'package:flutter/material.dart';
import 'package:web_app/data/appointment_database.dart';
import 'package:web_app/domain/appointment.dart';
import 'package:web_app/domain/service.dart';
import 'package:web_app/widgets/cards/service_feedback_card.dart';
import 'package:web_app/widgets/app_bar/non_home_app_bar.dart';
import 'package:web_app/widgets/section_title.dart';

class CheckServiceFeedbackPage extends StatefulWidget {
  CheckServiceFeedbackPage({
    super.key,
    required this.service,
  });

  final Service service;

  @override
  State<CheckServiceFeedbackPage> createState() =>
      CheckServiceFeedbackPageState();
}

class CheckServiceFeedbackPageState extends State<CheckServiceFeedbackPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.onError,
        appBar: NonHomeAppBar(context, text: "Ver opiniones del servicio"),
        body: FutureBuilder(
          future: getAppointmentsByBusinessName(widget.service.businessName),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            var appointments = snapshot.data!.docs
                .map((snapshotDoc) {
                  try {
                    var appointmentMap = snapshotDoc.data();
                    appointmentMap['uid'] = snapshotDoc.id;
                    return Appointment.fromMap(appointmentMap);
                  } catch (e) {
                    print('Error creating appointment: $e');
                    return null;
                  }
                })
                .where((app) => app?.rating != null || app?.comment != null)
                .cast<Appointment>()
                .toList();

            String sectionTitle = appointments.isEmpty
                ? 'Este servicio no ha recibido opiniones aún'
                : 'Hay ${appointments.length} opinion${appointments.length > 1 ? 'es' : ''} '
                    'del servicio ${widget.service.businessName}:';

            return ListView(
              padding: EdgeInsets.all(30),
              children: [
                SectionTitle(text: sectionTitle),
                for (var appointment in appointments)
                  ServiceFeedbackCard(appointment: appointment),
              ],
            );
          },
        ));
  }
}
