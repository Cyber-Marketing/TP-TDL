import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/app_state.dart';
import 'package:web_app/widgets/stream_builders/pending_appointed_services_stream_builder.dart';

class PendingAppointedServicesSection extends StatefulWidget {
  @override
  State<PendingAppointedServicesSection> createState() =>
      _PendingAppointedServicesSectionState();
}

class _PendingAppointedServicesSectionState
    extends State<PendingAppointedServicesSection> {
  @override
  Widget build(BuildContext context) {
    String userUid = context.watch<AppState>().currentUser!.uid;

    return PendingAppointedServicesStreamBuilder(userUid: userUid);
  }
}
