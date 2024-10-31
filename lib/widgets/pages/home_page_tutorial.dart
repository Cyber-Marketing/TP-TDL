import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_state.dart';
import '../authentication.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        toolbarHeight: 80,
        title: Row(
          children: [
            SizedBox(width: 25),
            IconButton(
                tooltip: "Inicio",
                onPressed: () {
                  // setState(() {
                  //   selectedIndex = 0;
                  // });
                },
                icon: const Icon(Icons.home)),
            SizedBox(width: 25),
            IconButton(
                onPressed: () {
                  // setState(() {
                  //   selectedIndex = 1;
                  // });
                },
                tooltip: "Mis turnos",
                icon: const Icon(Icons.event)),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          const SizedBox(height: 8),
          Consumer<AppState>(
            builder: (context, appState, _) => AuthFunc(
                loggedIn: appState.loggedIn,
                signOut: () {
                  FirebaseAuth.instance.signOut();
                }),
          ),
        ],
      ),
    );
  }
}
