import 'package:flutter/material.dart';
import 'package:web_app/custom_page_route.dart';
import 'package:web_app/domain/appointment.dart';
import 'package:web_app/domain/service.dart';
import 'package:web_app/widgets/colored_tag.dart';
import 'package:web_app/widgets/pages/appointments/make_appointment_page.dart';

class ServiceCard extends StatelessWidget {
  ServiceCard({
    super.key,
    required this.service,
  });

  final Service service;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Theme.of(context).colorScheme.inversePrimary,
      ),
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            service.businessName,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          Text(service.description),
          SizedBox(height: 10),
          ColoredTag(text: service.category),
          SizedBox(height: 20),
          Center(
            child: IconButton(
              tooltip: "Reservar turno",
              iconSize: 30,
              icon: const Icon(Icons.book),
              onPressed: () {
                Navigator.push(
                    context,
                    CustomPageRoute(
                        pageWidget: MakeAppointmentPage(
                            appointment: Appointment(
                                businessName: service.businessName,
                                serviceDescription: service.description,
                                category: service.category,
                                servicePrice: service.price,
                                serviceDuration: Duration(
                                    hours: service.duration ~/ 60,
                                    minutes: service.duration.round() % 60)))));
              },
            ),
          )
        ],
      ),
    );
  }
}
