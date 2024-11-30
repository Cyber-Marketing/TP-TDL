import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/app_state.dart';
import 'package:web_app/widgets/stream_builders/cancelled_stream_builder.dart';

class CancelledAppointmentsSection extends StatefulWidget {
  @override
  State<CancelledAppointmentsSection> createState() =>
      _CancelledAppointmentsSectionState();
}

class _CancelledAppointmentsSectionState
    extends State<CancelledAppointmentsSection> {
  @override
  Widget build(BuildContext context) {
    String userUid = context.watch<AppState>().currentUser!.uid;

    return CancelledStreamBuilder(userUid: userUid);
  }
}
