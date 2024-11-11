import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loader_overlay/loader_overlay.dart';

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
    var loaderOverlay = context.loaderOverlay;

    return LoaderOverlay(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        body: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                textAlign: TextAlign.center,
                decoration: customFieldDecoration.copyWith(
                    hintText: 'Ingresá tu email'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Email no puede ser vacío";
                  }
                  if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                      .hasMatch(value)) {
                    return ("Please enter a valid email");
                  } else {
                    return null;
                  }
                },
                onChanged: (value) => email = value,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 8.0,
              ),
              TextFormField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: customFieldDecoration.copyWith(
                    hintText: 'Ingresá tu contraseña'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Contraseña no puede ser vacía";
                  }
                  return null;
                },
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
                onPressed: () async {
                  if (!formKey.currentState!.validate()) return;
                  loaderOverlay.show();
                  try {
                    await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                          email: email,
                          password: password,
                        )
                        .then((value) =>
                            saveUserRole(value.user, selectedUserRole));
                  } on FirebaseAuthException catch (e) {
                    String errorMessage = 'Default error';
                    if (e.code == 'weak-password') {
                      errorMessage = 'The password provided is too weak.';
                    } else if (e.code == 'email-already-in-use') {
                      errorMessage =
                          'The account already exists for that email.';
                    }
                    loaderOverlay.hide();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(errorMessage)),
                    );
                    return;
                  } catch (e) {
                    print(e);
                  }
                  loaderOverlay.hide();
                  Navigator.pushNamed(context, 'home_screen');
                },
                child: const Text('Registrarse'),
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
