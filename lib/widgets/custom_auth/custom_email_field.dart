import 'package:flutter/material.dart';
import 'package:web_app/widgets/custom_auth/custom_input_decoration.dart';

class CustomEmailField extends StatelessWidget {
  CustomEmailField({super.key, required this.onChanged});

  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: 0.25 * screenWidth,
      child: TextFormField(
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
          keyboardType: TextInputType.emailAddress,
          textAlign: TextAlign.left,
          onChanged: onChanged,
          decoration: CustomInputDecoration(
            hintText: 'Ingresá tu email',
            context: context,
          )),
    );
  }
}
