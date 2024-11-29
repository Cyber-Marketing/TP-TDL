import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/app_state.dart';
import 'package:web_app/widgets/stream_builders/service_cancelled_stream_builder.dart';

class ServiceCancelledAppointmentsPage extends StatefulWidget {
  @override
  State<ServiceCancelledAppointmentsPage> createState() =>
      _ServiceCancelledAppointmentsPageState();
}

class _ServiceCancelledAppointmentsPageState
    extends State<ServiceCancelledAppointmentsPage> {
  @override
  Widget build(BuildContext context) {
    String userUid = context.watch<AppState>().currentUser!.uid;

    return ServiceCancelledStreamBuilder(userUid: userUid);
  }
}
