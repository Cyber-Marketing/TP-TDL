import 'package:flutter/material.dart';
import '../cards/appointment_card.dart';
import '../../domain/appointment.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(50),
      crossAxisCount: 3,
      crossAxisSpacing: 30,
      mainAxisSpacing: 50,
      childAspectRatio: 2,
      children: [
        for (int i = 0; i < 10; i++)
          AppointmentCard(
            appointment: Appointment(),
          )
      ],
    );
  }
}
