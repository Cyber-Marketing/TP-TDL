import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:web_app/widgets/tutorial_widgets.dart';

class PreviewPage extends StatelessWidget {
  const PreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      body: ListView(
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text('Bienvenido a la app'),
            ),
          ),
          Center(
            child: StyledButton(
                child: const Text("Sign in"),
                onPressed: () => context.goNamed('sign-in')),
          )
          // Consumer<AppState>(
          //   builder: (context, appState, _) => AuthFunc(
          //       loggedIn: appState.loggedIn,
          //       signOut: () {
          //         FirebaseAuth.instance.signOut();
          //       }),
          // ),
        ],
      ),
    );
  }
}
