import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:web_app/routing/custom_page_route.dart';
import 'package:web_app/widgets/form_fields/custom_email_field.dart';
import 'package:web_app/widgets/form_fields/custom_password_field.dart';
import 'package:web_app/widgets/pages/auth/auth_gate.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    var loaderOverlay = context.loaderOverlay;

    return LoaderOverlay(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.onError,
        body: Form(
          key: formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Inicio de sesión',
                    style: TextStyle(
                        fontSize: 50,
                        color: Theme.of(context).colorScheme.primary)),
                SizedBox(height: 40),
                CustomEmailField(onChanged: (value) {
                  email = value;
                }),
                SizedBox(
                  height: 8.0,
                ),
                CustomPasswordField(
                  onChanged: (value) {
                    password = value;
                  },
                ),
                SizedBox(
                  height: 24.0,
                ),
                ElevatedButton(
                  child: Text('Iniciar sesión'),
                  onPressed: () async {
                    if (!formKey.currentState!.validate()) return;
                    loaderOverlay.show();
                    try {
                      await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        print('No user found for that email.');
                      } else if (e.code == 'wrong-password') {
                        print('Wrong password provided for that user.');
                      }
                    } catch (e) {
                      print(e);
                    }
                    loaderOverlay.hide();
                    if (context.mounted) {
                      Navigator.push(
                          context, CustomPageRoute(pageWidget: AuthGate()));
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
