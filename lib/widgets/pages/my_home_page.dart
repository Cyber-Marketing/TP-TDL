import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/app_state.dart';
import 'package:web_app/widgets/app_bar/auth_buttons.dart';
import 'package:web_app/widgets/app_bar/app_bar_button.dart';
import 'package:web_app/widgets/buttons/new_service_button.dart';
import 'package:web_app/widgets/form_fields/custom_search_delegate.dart';
import 'package:web_app/widgets/sections/provider_only/ended_appointed_services_section.dart';
import 'package:web_app/widgets/sections/provider_only/my_services_section.dart';
import '../sections/main_section.dart';
import '../sections/customer_only/pending_appointments_section.dart';
import '../sections/customer_only/ended_appointments_section.dart';
import '../sections/customer_only/cancelled_appointments_section.dart';
import '../sections/provider_only/cancelled_appointed_services_section.dart';
import '../sections/provider_only/pending_appointed_services_section.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedSection = 0;

  @override
  Widget build(BuildContext context) {
    Widget section;
    switch (selectedSection) {
      case 0:
        section = MainSection();
      case 1:
        section = PendingAppointmentsSection();
      case 2:
        section = CancelledAppointmentsSection();
      case 3:
        section = EndedAppointmentsSection();
      case 4:
        section = MyServicesSection();
      case 5:
        section = PendingAppointedServicesSection();
      case 6:
        section = CancelledAppointedServicesSection();
      case 7:
        section = EndedAppointedServicesSection();
      default:
        throw UnimplementedError('no widget for $selectedSection');
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
          toolbarHeight: 80,
          title: Row(
            children: [
              AppBarButton(
                tooltip: "Inicio",
                icon: Icons.home,
                onPressed: () {
                  setState(() {
                    selectedSection = 0;
                  });
                },
              ),
              Consumer<AppState>(
                builder: (_, appState, __) => Visibility(
                  visible: appState.isSignedIn && appState.userIsCustomer(),
                  child: AppBarButton(
                    tooltip: "Turnos pendientes",
                    icon: Icons.date_range,
                    onPressed: () {
                      setState(() {
                        selectedSection = 1;
                      });
                    },
                  ),
                ),
              ),
              Consumer<AppState>(
                builder: (_, appState, __) => Visibility(
                  visible: appState.isSignedIn && appState.userIsCustomer(),
                  child: AppBarButton(
                    tooltip: "Turnos cancelados",
                    icon: Icons.event_busy,
                    onPressed: () {
                      setState(() {
                        selectedSection = 2;
                      });
                    },
                  ),
                ),
              ),
              Consumer<AppState>(
                builder: (_, appState, __) => Visibility(
                  visible: appState.isSignedIn && appState.userIsCustomer(),
                  child: AppBarButton(
                    tooltip: "Turnos terminados",
                    icon: Icons.event_repeat,
                    onPressed: () {
                      setState(() {
                        selectedSection = 3;
                      });
                    },
                  ),
                ),
              ),
              Consumer<AppState>(
                builder: (_, appState, __) => Visibility(
                  visible: appState.isSignedIn && !appState.userIsCustomer(),
                  child: AppBarButton(
                    tooltip: "Mis servicios",
                    icon: Icons.store_outlined,
                    onPressed: () {
                      setState(() {
                        selectedSection = 4;
                      });
                    },
                  ),
                ),
              ),
              Consumer<AppState>(
                builder: (_, appState, __) => Visibility(
                  visible: appState.isSignedIn && !appState.userIsCustomer(),
                  child: AppBarButton(
                    tooltip: "Servicios pendientes",
                    icon: Icons.work_history_outlined,
                    onPressed: () {
                      setState(() {
                        selectedSection = 5;
                      });
                    },
                  ),
                ),
              ),
              Consumer<AppState>(
                builder: (_, appState, __) => Visibility(
                  visible: appState.isSignedIn && !appState.userIsCustomer(),
                  child: AppBarButton(
                    tooltip: "Servicios cancelados",
                    icon: Icons.work_off_outlined,
                    onPressed: () {
                      setState(() {
                        selectedSection = 6;
                      });
                    },
                  ),
                ),
              ),
              Consumer<AppState>(
                builder: (_, appState, __) => Visibility(
                  visible: appState.isSignedIn && !appState.userIsCustomer(),
                  child: AppBarButton(
                    tooltip: "Servicios terminados",
                    icon: Icons.hourglass_bottom_outlined,
                    onPressed: () {
                      setState(() {
                        selectedSection = 7;
                      });
                    },
                  ),
                ),
              ),
              Consumer<AppState>(
                builder: (_, appState, __) => Visibility(
                  visible: appState.isSignedIn,
                  child: AppBarButton(
                    tooltip: "Buscador",
                    icon: Icons.search,
                    onPressed: () {
                      showSearch(
                        context: context,
                        delegate: CustomSearchDelegate(
                            selectedSection: selectedSection),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          actions: [
            Consumer<AppState>(
              builder: (context, appState, _) => AuthButtons(
                  isSignedIn: appState.isSignedIn,
                  signOut: FirebaseAuth.instance.signOut),
            ),
            SizedBox(width: 25),
          ],
        ),
        body: Container(
          color: Theme.of(context).colorScheme.onError,
          child: section,
        ),
        floatingActionButton: Consumer<AppState>(
          builder: (_, appState, __) => Visibility(
              visible: appState.isSignedIn && !appState.userIsCustomer(),
              child: NewServiceButton()),
        ),
      );
    });
  }
}
