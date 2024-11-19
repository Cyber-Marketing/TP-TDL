import 'package:flutter/material.dart';
import 'package:web_app/custom_page_route.dart';
import 'package:web_app/widgets/pages/auth/login_screen.dart';
import 'package:web_app/widgets/pages/auth/registration_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: Text('Iniciar sesión'),
                  onPressed: () {
                    Navigator.push(
                        context, CustomPageRoute(pageWidget: LoginScreen()));
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                    child: Text('Registrarse'),
                    onPressed: () {
                      Navigator.push(context,
                          CustomPageRoute(pageWidget: RegistrationScreen()));
                    }),
              ]),
        ));
  }
}
