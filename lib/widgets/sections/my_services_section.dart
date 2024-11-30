import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/app_state.dart';
import 'package:web_app/widgets/stream_builders/my_services_stream_builder.dart';

class MyServicesSection extends StatefulWidget {
  @override
  State<MyServicesSection> createState() => _MyServicesSectionState();
}

class _MyServicesSectionState extends State<MyServicesSection> {
  @override
  Widget build(BuildContext context) {
    String userUid = context.watch<AppState>().currentUser!.uid;

    return MyServicesStreamBuilder(userUid: userUid);
  }
}
