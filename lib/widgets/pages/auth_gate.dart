import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/app_state.dart';
import 'package:web_app/widgets/pages/my_home_page.dart';
import 'package:web_app/widgets/pages/sign_in_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    return appState.isSignedIn ? MyHomePage() : SignInPage();
  }
}
