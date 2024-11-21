import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/app_state.dart';
import 'package:web_app/widgets/buttons/auth_buttons.dart';
import 'package:web_app/widgets/buttons/app_bar_button.dart';
import 'package:web_app/widgets/buttons/new_service_button.dart';
import 'package:web_app/widgets/pages/my_services_page.dart';
import 'main_page.dart';
import 'appointments/pending_appointments_page.dart';
import 'appointments/ended_appointments_page.dart';
import 'appointments/cancelled_appointments_page.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = MainPage();
      case 1:
        page = PendingAppointmentsPage();
      case 2:
        page = CancelledAppointmentsPage();
      case 3:
        page = EndedAppointmentsPage();
      case 4:
        page = MyServicesPage();
      default:
        throw UnimplementedError('no widget for $selectedIndex');
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
                    selectedIndex = 0;
                  });
                },
              ),
              Consumer<AppState>(
                builder: (_, appState, __) => Visibility(
                  visible: appState.isSignedIn && appState.userIsCustomer(),
                  child: AppBarButton(
                    tooltip: "Turnos pendientes",
                    icon: Icons.event,
                    onPressed: () {
                      setState(() {
                        selectedIndex = 1;
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
                        selectedIndex = 2;
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
                        selectedIndex = 3;
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
                        selectedIndex = 4;
                      });
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
          color: Theme.of(context).colorScheme.primaryContainer,
          child: page,
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
