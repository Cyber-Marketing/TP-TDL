import 'package:flutter/material.dart';
import 'package:web_app/widgets/custom_auth/custom_input_decoration.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({super.key, required this.onChanged});

  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: 0.25 * screenWidth,
      child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return "Campo no puede ser vacío";
            }
            return null;
          },
          onChanged: onChanged,
          keyboardType: TextInputType.name,
          textAlign: TextAlign.left,
          decoration: CustomInputDecoration(
            hintText: '...',
            context: context,
          )),
    );
  }
}
