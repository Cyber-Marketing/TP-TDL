import 'package:flutter/material.dart';
import 'package:web_app/domain/appointment.dart';
import 'package:web_app/widgets/rating_stars.dart';

class ServiceFeedbackCard extends StatelessWidget {
  ServiceFeedbackCard({required this.appointment});

  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Theme.of(context).colorScheme.inversePrimary,
      ),
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
              visible: appointment.rating != null,
              child: RatingStars(rating: appointment.rating ?? 1)),
          Visibility(
              visible: appointment.comment != null,
              child: Row(
                children: [
                  Text("Comentario del cliente del servicio: ", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("${appointment.comment}")
                ]
                )
          )
        ],
      ),
    );
  }
}
