import 'package:flutter/material.dart';
import 'package:web_app/widgets/form_fields/custom_input_decoration.dart';

class CustomPasswordField extends StatelessWidget {
  CustomPasswordField({super.key, required this.onChanged});

  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: 0.25 * screenWidth,
      child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return "Contraseña no puede ser vacía";
            }
            return null;
          },
          obscureText: true,
          textAlign: TextAlign.left,
          onChanged: onChanged,
          decoration: CustomInputDecoration(
              hintText: 'Ingresá tu contraseña', context: context)),
    );
  }
}
