import 'package:flutter/material.dart';
import 'package:web_app/custom_page_route.dart';
import 'package:web_app/domain/appointment.dart';
import 'package:web_app/domain/service.dart';
import 'package:web_app/widgets/pages/make_appointment_page.dart';

class ServiceCard extends StatelessWidget {
  ServiceCard({
    super.key,
    required this.service,
  });

  final Service service;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.inversePrimary,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Negocio: ${service.businessName}\nDescripción: ${service.description}\nPrecio: ${service.price.toStringAsFixed(2)}",
            style: TextStyle(fontSize: 20),
          ),
          IconButton(
              iconSize: 30,
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
              icon: const Icon(Icons.book))
        ],
      )),
    );
  }
}
