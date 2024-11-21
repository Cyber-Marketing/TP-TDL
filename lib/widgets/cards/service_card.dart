import 'package:flutter/material.dart';
import 'package:web_app/domain/service.dart';

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
          Text(service.businessName),
          Text(service.description),
          Text(service.category),
          Text(service.duration.toString()),
          Text(service.price.toString()),
          // isCancellable
          //     ? IconButton(
          //         icon: Icon(Icons.disabled_by_default),
          //         tooltip: "Cancelar",
          //         color: Theme.of(context).colorScheme.onPrimaryContainer,
          //         onPressed: () => showDialog<String>(
          //           context: context,
          //           builder: (BuildContext context) => AlertDialog(
          //             title: Text('¿Seguro querés cancelar el turno?'),
          //             actions: [
          //               TextButton(
          //                 child: Text('No'),
          //                 onPressed: () => Navigator.pop(context),
          //               ),
          //               TextButton(
          //                 child: Text('Sí'),
          //                 onPressed: () {
          //                   cancelAppointment(userUid, appointment);
          //                   Navigator.pop(context);
          //                   ScaffoldMessenger.of(context).showSnackBar(
          //                       SnackBar(content: Text('Turno cancelado')));
          //                 },
          //               ),
          //             ],
          //           ),
          //         ),
          //       )
          //     : Container()
        ],
      ),
    );
  }
}
