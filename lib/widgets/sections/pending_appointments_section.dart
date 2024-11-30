import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/app_state.dart';
import 'package:web_app/widgets/stream_builders/pending_stream_builder.dart';

class PendingAppointmentsSection extends StatefulWidget {
  @override
  State<PendingAppointmentsSection> createState() =>
      _PendingAppointmentsSectionState();
}

class _PendingAppointmentsSectionState
    extends State<PendingAppointmentsSection> {
  @override
  Widget build(BuildContext context) {
    String userUid = context.watch<AppState>().currentUser!.uid;

    return PendingStreamBuilder(userUid: userUid);
  }
}
