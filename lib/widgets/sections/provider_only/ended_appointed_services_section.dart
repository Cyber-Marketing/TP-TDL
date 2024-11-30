import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/app_state.dart';
import 'package:web_app/widgets/stream_builders/ended_appointed_services_stream_builder.dart';

class EndedAppointedServicesSection extends StatefulWidget {
  @override
  State<EndedAppointedServicesSection> createState() =>
      _EndedAppointedServicesSectionState();
}

class _EndedAppointedServicesSectionState
    extends State<EndedAppointedServicesSection> {
  @override
  Widget build(BuildContext context) {
    String userUid = context.watch<AppState>().currentUser!.uid;

    return EndedAppointedServicesStreamBuilder(userUid: userUid);
  }
}
