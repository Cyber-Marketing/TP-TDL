import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:web_app/domain/appointment_database.dart';
import 'package:web_app/widgets/custom_auth/custom_email_field.dart';
import 'package:web_app/widgets/custom_auth/custom_password_field.dart';

const customFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  hintStyle: TextStyle(color: Colors.grey),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

class RegistrationScreen extends StatefulWidget {
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final formKey = GlobalKey<FormState>();
  late String email;
  late String password;
  List<String> options = ['Cliente', 'Proveedor'];
  String selectedUserRole = 'Cliente';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      body: Form(
        key: formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomEmailField(
                onChanged: (value) => email = value,
              ),
              SizedBox(
                height: 8.0,
              ),
              CustomPasswordField(
                onChanged: (value) => password = value,
              ),
              SizedBox(
                height: 8.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Elegí el tipo de usuario:'),
                  SizedBox(width: 15),
                  DropdownButton(
                    value: selectedUserRole,
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
                        selectedUserRole = newSelectedRole!;
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
                  try {
                    await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                    )
                        .then((value) {
                      saveUserRole(value.user, selectedUserRole);
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

                  if (context.mounted) {
                    Navigator.pushNamed(context, '');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

saveUserRole(User? user, String role) async {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  users
      .add({
        'uid': user?.uid,
        'email': user?.email,
        'role': role,
      })
      .then((value) => print("User added successfully!"))
      .catchError((error) => print("Failed to add user: $error"));
  return;
}
