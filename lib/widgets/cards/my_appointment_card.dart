import 'package:flutter/material.dart';
import 'package:web_app/routing/custom_page_route.dart';
import 'package:web_app/data/appointment_database.dart';
import 'package:web_app/domain/appointment.dart';
import 'package:web_app/widgets/colored_tag.dart';
import 'package:web_app/widgets/pages/appointments/give_appointment_feedback_page.dart';
import 'package:web_app/widgets/rating_stars.dart';

class MyAppointmentCard extends StatelessWidget {
  const MyAppointmentCard({super.key, required this.appointment});

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
            appointment.businessName,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Row(
            children: [
              Text("- Descripcion: ",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(appointment.serviceDescription)
            ],
          ),
          Row(
            children: [
              Text("- Dia del servicio: ",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(appointment.getServiceDay())
            ],
          ),
          Row(
            children: [
              Text("- Horario del servicio: ",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(appointment.getServiceTime())
            ],
          ),
          Row(
            children: [
              Text("- Precio del servicio: ",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text("\$${appointment.servicePrice}")
            ],
          ),
          SizedBox(height: 15),
          Visibility(
              visible: appointment.hasEnded(),
              child: ColoredTag(
                  text: appointment.wasAttended ? 'Asistido ✅' : 'Perdido ❌')),
          SizedBox(height: 5),
          Visibility(
              visible: appointment.rating != null,
              child: RatingStars(rating: appointment.rating ?? 1)),
          SizedBox(height: 5),
          Visibility(
              visible: appointment.comment != null,
              child: Text('Tu comentario: ${appointment.comment}')),
          Visibility(
            visible: !appointment.isCancelled && !appointment.hasEnded(),
            child: IconButton(
              icon: Icon(Icons.disabled_by_default),
              tooltip: "Cancelar",
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text('¿Seguro querés cancelar el turno?'),
                  actions: [
                    TextButton(
                      child: Text('No'),
                      onPressed: () => Navigator.pop(context),
                    ),
                    TextButton(
                      child: Text('Sí'),
                      onPressed: () {
                        cancelAppointment(appointment);
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Turno cancelado')));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: appointment.wasAttended && appointment.rating == null,
            child: IconButton(
              icon: Icon(Icons.grading_outlined),
              tooltip: "Dar feedback",
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              onPressed: () {
                Navigator.push(
                    context,
                    CustomPageRoute(
                        pageWidget: GiveAppointmentFeedbackPage(
                            appointment: appointment)));
              },
            ),
          )
        ],
      ),
    );
  }
}
