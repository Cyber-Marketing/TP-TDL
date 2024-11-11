import 'package:flutter/material.dart';
import 'package:web_app/widgets/custom_auth/custom_input_decoration.dart';

class CustomPasswordField extends StatelessWidget {
  CustomPasswordField({super.key, required this.onChanged});

  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return "Contraseña no puede ser vacía";
          }
          return null;
        },
        obscureText: true,
        textAlign: TextAlign.center,
        onChanged: onChanged,
        decoration: CustomInputDecoration(
          hintText: 'Ingresá tu contraseña',
        ));
  }
}
