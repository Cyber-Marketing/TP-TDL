import 'package:flutter/material.dart';
import 'package:web_app/widgets/buttons/styled_button.dart';

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
                StyledButton(
                  text: 'Iniciar sesión',
                  onPressed: () {
                    Navigator.pushNamed(context, 'login_screen');
                  },
                ),
                SizedBox(height: 10),
                StyledButton(
                    text: 'Registrarse',
                    onPressed: () {
                      Navigator.pushNamed(context, 'registration_screen');
                    }),
              ]),
        ));
  }
}
