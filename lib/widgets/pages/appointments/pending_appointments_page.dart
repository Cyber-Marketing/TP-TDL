import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/app_state.dart';
import 'package:web_app/widgets/stream_builders/pending_stream_builder.dart';

class PendingAppointmentsPage extends StatefulWidget {
  @override
  State<PendingAppointmentsPage> createState() =>
      _PendingAppointmentsPageState();
}

class _PendingAppointmentsPageState extends State<PendingAppointmentsPage> {
  @override
  Widget build(BuildContext context) {
    String userUid = context.watch<AppState>().currentUser!.uid;

    return PendingStreamBuilder(userUid: userUid);
  }
}
