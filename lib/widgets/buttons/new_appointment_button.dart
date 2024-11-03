import 'package:flutter/material.dart';

class NewAppointmentButton extends StatelessWidget {
  const NewAppointmentButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: () {},
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        child: Icon(Icons.post_add,
            color: Theme.of(context).colorScheme.surfaceBright));
  }
}
