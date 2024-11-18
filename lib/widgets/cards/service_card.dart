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
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.inversePrimary,
          ),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Negocio: ",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),

          ),
          Text(
            service.businessName,
            style: TextStyle(fontSize: 13),

          ),
          Text(
            "Descripción: ",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),

          ),
          Text(
            service.description,
            style: TextStyle(fontSize: 13),

          ),
          Text(
            "Precio: ",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),

          ),
          Text(
            service.price.toStringAsFixed(2),
            style: TextStyle(fontSize: 13),

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
