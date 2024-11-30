import 'package:flutter/material.dart';
import 'package:web_app/routing/custom_page_route.dart';
import 'package:web_app/data/service_repository.dart';
import 'package:web_app/domain/service.dart';
import 'package:web_app/widgets/colored_tag.dart';
import 'package:web_app/widgets/pages/services/check_service_feedback_page.dart';

class MyServiceCard extends StatelessWidget {
  MyServiceCard({required this.service});

  final Service service;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Theme.of(context).colorScheme.inversePrimary,
      ),
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ColoredTag(text: service.category),
        SizedBox(height: 15),
        Text(
          service.businessName,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Row(
          children: [
            Text("- Descripcion: ",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(service.description)
          ],
        ),
        Row(
          children: [
            Text("- Duración del servicio: ",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text("${service.duration.toString()} minutos")
          ],
        ),
        Row(
          children: [
            Text("- Precio del servicio: ",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text("\$${service.price.toString()}")
          ],
        ),
        SizedBox(height: 15),
        Row(children: [
          IconButton(
            tooltip: "Ver opiniones",
            iconSize: 18,
            icon: const Icon(Icons.forum),
            onPressed: () {
              Navigator.push(
                  context,
                  CustomPageRoute(
                      pageWidget: CheckServiceFeedbackPage(service: service)));
            },
          ),
          SizedBox(width: 20),
          IconButton(
            icon: Icon(Icons.delete),
            iconSize: 18,
            tooltip: "Eliminar",
            onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: Text('¿Seguro querés eliminar el servicio?'),
                actions: [
                  TextButton(
                    child: Text('No'),
                    onPressed: () => Navigator.pop(context),
                  ),
                  TextButton(
                    child: Text('Sí'),
                    onPressed: () {
                      ServicesRepository().delete(service.uid);
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Servicio eliminado')));
                    },
                  ),
                ],
              ),
            ),
          )
        ])
      ]),
    );
  }
}
