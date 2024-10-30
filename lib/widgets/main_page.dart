import 'package:flutter/material.dart';
import 'package:web_app/widgets/appointment_card.dart';
import 'package:web_app/domain/appointment.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // var appState = context.watch<MyAppState>();
    // var pair = appState.current;

    // IconData icon;
    // if (appState.favorites.contains(pair)) {
    //   icon = Icons.favorite;
    // } else {
    //   icon = Icons.favorite_border;
    // }

    return GridView.count(
      padding: const EdgeInsets.all(50),
      crossAxisCount: 3,
      crossAxisSpacing: 30,
      mainAxisSpacing: 50,
      childAspectRatio: 2,
      children: [
        for (int i = 0; i < 50; i++)
          AppointmentCard(
            appointment: Appointment(),
          )
      ],
    );
  }
}
