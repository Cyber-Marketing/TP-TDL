import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/app_state.dart';
import 'package:web_app/widgets/stream_builders/cancelled_stream_builder.dart';

class CancelledAppointmentsPage extends StatefulWidget {
  @override
  State<CancelledAppointmentsPage> createState() =>
      _CancelledAppointmentsPageState();
}

class _CancelledAppointmentsPageState extends State<CancelledAppointmentsPage> {
  @override
  Widget build(BuildContext context) {
    String userUid = context.watch<AppState>().currentUser!.uid;

    return CancelledStreamBuilder(userUid: userUid);
  }
}
