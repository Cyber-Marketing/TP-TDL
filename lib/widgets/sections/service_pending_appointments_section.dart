import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/app_state.dart';
import 'package:web_app/widgets/stream_builders/service_pending_stream_builder.dart';

class ServicePendingAppointmentsSection extends StatefulWidget {
  @override
  State<ServicePendingAppointmentsSection> createState() =>
      _ServicePendingAppointmentsSectionState();
}

class _ServicePendingAppointmentsSectionState
    extends State<ServicePendingAppointmentsSection> {
  @override
  Widget build(BuildContext context) {
    String userUid = context.watch<AppState>().currentUser!.uid;

    return ServicePendingStreamBuilder(userUid: userUid);
  }
}
