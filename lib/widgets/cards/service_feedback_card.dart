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
          Text(
            appointment.userFullName,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: 5,
          ),
          Visibility(
              visible: appointment.comment != null,
              child: Text(
                '"${appointment.comment}"',
                style: TextStyle(fontStyle: FontStyle.italic),
              )),
          SizedBox(
            height: 5,
          ),
          Visibility(
              visible: appointment.rating != null,
              child: RatingStars(rating: appointment.rating ?? 1)),
        ],
      ),
    );
  }
}
