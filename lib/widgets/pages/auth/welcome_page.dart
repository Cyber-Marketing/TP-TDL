import 'package:flutter/material.dart';
import 'package:web_app/routing/custom_page_route.dart';
import 'package:web_app/widgets/pages/auth/login_page.dart';
import 'package:web_app/widgets/pages/auth/registration_page.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.onError,
        body: Center(
          child: Container(
            margin: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.25,
                horizontal: MediaQuery.of(context).size.width * 0.35),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                  color: Theme.of(context).colorScheme.primary, width: 1.5),
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('App Turnos',
                      style: TextStyle(
                          fontSize: 50,
                          color: Theme.of(context).colorScheme.primary)),
                  SizedBox(height: 30),
                  ElevatedButton(
                    child: Text('Iniciar sesión'),
                    onPressed: () {
                      Navigator.push(
                          context, CustomPageRoute(pageWidget: LoginPage()));
                    },
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                      child: Text('Registrarse'),
                      onPressed: () {
                        Navigator.push(context,
                            CustomPageRoute(pageWidget: RegistrationPage()));
                      }),
                ]),
          ),
        ));
  }
}
