import 'package:flutter/material.dart';
import 'package:web_app/data/service_repository.dart';
import 'package:web_app/domain/service.dart';
import 'package:web_app/widgets/colored_tag.dart';

class ServiceCard extends StatelessWidget {
  ServiceCard({required this.service});

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ColoredTag(text: service.category),
          Text(
            service.businessName,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Text(service.description),
          Text("Duración: ${service.duration.toString()} minutos"),
          Text("Precio: \$${service.price.toString()}"),
          IconButton(
            icon: Icon(Icons.delete_outlined),
            tooltip: "Eliminar",
            color: Theme.of(context).colorScheme.onPrimaryContainer,
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
        ],
      ),
    );
  }
}
