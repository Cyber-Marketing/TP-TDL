import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/app_state.dart';
import 'package:web_app/widgets/stream_builders/cancelled_appointed_services_stream_builder.dart';

class CancelledAppointedServicesSection extends StatefulWidget {
  @override
  State<CancelledAppointedServicesSection> createState() =>
      _CancelledAppointedServicesSectionState();
}

class _CancelledAppointedServicesSectionState
    extends State<CancelledAppointedServicesSection> {
  @override
  Widget build(BuildContext context) {
    String userUid = context.watch<AppState>().currentUser!.uid;

    return CancelledAppointedServicesStreamBuilder(userUid: userUid);
  }
}
