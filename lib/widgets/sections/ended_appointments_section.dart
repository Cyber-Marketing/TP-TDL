import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/app_state.dart';
import 'package:web_app/widgets/stream_builders/ended_stream_builder.dart';

class EndedAppointmentsSection extends StatefulWidget {
  @override
  State<EndedAppointmentsSection> createState() =>
      _EndedAppointmentsSectionState();
}

class _EndedAppointmentsSectionState extends State<EndedAppointmentsSection> {
  @override
  Widget build(BuildContext context) {
    String userUid = context.watch<AppState>().currentUser!.uid;

    return EndedStreamBuilder(userUid: userUid);
  }
}
