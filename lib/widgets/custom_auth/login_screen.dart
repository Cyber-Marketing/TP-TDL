import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:web_app/widgets/form_fields/custom_email_field.dart';
import 'package:web_app/widgets/form_fields/custom_password_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    var loaderOverlay = context.loaderOverlay;

    return LoaderOverlay(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        body: Form(
          key: formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                      Navigator.pushNamed(context, '');
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
