import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/app_state.dart';
import 'package:web_app/widgets/stream_builders/service_pending_stream_builder.dart';

class ServicePendingAppointmentsPage extends StatefulWidget {
  @override
  State<ServicePendingAppointmentsPage> createState() =>
      _ServicePendingAppointmentsPageState();
}

class _ServicePendingAppointmentsPageState
    extends State<ServicePendingAppointmentsPage> {
  @override
  Widget build(BuildContext context) {
    String userUid = context.watch<AppState>().currentUser!.uid;

    return ServicePendingStreamBuilder(userUid: userUid);
  }
}
