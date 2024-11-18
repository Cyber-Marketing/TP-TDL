import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:web_app/custom_page_route.dart';
import 'package:web_app/data/appointment_database.dart';
import 'package:web_app/data/users_repository.dart';
import 'package:web_app/domain/app_user.dart';
import 'package:web_app/widgets/form_fields/custom_email_field.dart';
import 'package:web_app/widgets/form_fields/custom_password_field.dart';
import 'package:web_app/widgets/form_fields/custom_text_field.dart';
import 'package:web_app/widgets/pages/auth_gate.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final formKey = GlobalKey<FormState>();
  AppUser appUser = AppUser(role: 'Cliente');
  List<String> options = ['Cliente', 'Proveedor'];

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
                CustomTextField(
                  hintText: 'Ingresá tu nombre',
                  onChanged: (value) => appUser.name = value,
                ),
                SizedBox(
                  height: 8.0,
                ),
                CustomTextField(
                  hintText: 'Ingresá tu apellido',
                  onChanged: (value) => appUser.lastName = value,
                ),
                SizedBox(
                  height: 8.0,
                ),
                CustomEmailField(
                  onChanged: (value) => appUser.email = value,
                ),
                SizedBox(
                  height: 8.0,
                ),
                CustomPasswordField(
                  onChanged: (value) => appUser.password = value,
                ),
                SizedBox(
                  height: 8.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('¿Qué tipo de usuario sos?:'),
                    SizedBox(width: 15),
                    DropdownButton(
                      value: appUser.role,
                      items: options.map((String dropDownStringItem) {
                        return DropdownMenuItem(
                          value: dropDownStringItem,
                          child: Text(
                            dropDownStringItem,
                          ),
                        );
                      }).toList(),
                      onChanged: (newSelectedRole) {
                        setState(() {
                          appUser.role = newSelectedRole!;
                        });
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 8.0,
                ),
                ElevatedButton(
                  child: Text('Registrarse'),
                  onPressed: () async {
                    if (!formKey.currentState!.validate()) return;
                    loaderOverlay.show();
                    try {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: appUser.email,
                        password: appUser.password,
                      )
                          .then((value) {
                        appUser.uid = value.user!.uid;
                        UsersRepository().save(appUser);
                        // Mover coleccion de appointments de un user adentro del documento user
                        addCustomerAppointment(value.user!.uid);
                      });
                    } on FirebaseAuthException catch (e) {
                      String errorMessage = 'Default error';
                      if (e.code == 'weak-password') {
                        errorMessage = 'The password provided is too weak.';
                      } else if (e.code == 'email-already-in-use') {
                        errorMessage =
                            'The account already exists for that email.';
                      }
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(errorMessage)),
                        );
                      }

                      return;
                    } catch (e) {
                      print(e);
                    }
                    loaderOverlay.hide();
                    if (context.mounted) {
                      Navigator.push(
                          context, CustomPageRoute(pageWidget: AuthGate()));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

saveUserProfile(AppUser appUser) async {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  users
      .add(appUser.toMap())
      .then((value) => print("User added successfully!"))
      .catchError((error) => print("Failed to add user: $error"));
  return;
}
