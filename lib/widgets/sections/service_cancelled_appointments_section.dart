import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/app_state.dart';
import 'package:web_app/widgets/stream_builders/service_cancelled_stream_builder.dart';

class ServiceCancelledAppointmentsSection extends StatefulWidget {
  @override
  State<ServiceCancelledAppointmentsSection> createState() =>
      _ServiceCancelledAppointmentsSectionState();
}

class _ServiceCancelledAppointmentsSectionState
    extends State<ServiceCancelledAppointmentsSection> {
  @override
  Widget build(BuildContext context) {
    String userUid = context.watch<AppState>().currentUser!.uid;

    return ServiceCancelledStreamBuilder(userUid: userUid);
  }
}
