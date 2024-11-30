import 'package:flutter/material.dart';
import 'package:web_app/data/appointment_database.dart';
import 'package:web_app/domain/appointment.dart';
import 'package:web_app/widgets/colored_tag.dart';

class AppointedServiceCard extends StatelessWidget {
  const AppointedServiceCard({super.key, required this.appointment});

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
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
              Text("- Dia y horario: ",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(
                  "${appointment.getServiceDay()} ${appointment.getServiceTime()}")
            ],
          ),
          Row(
            children: [
              Text("- Precio del servicio: ",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text("\$${appointment.servicePrice}")
            ],
          ),
          Row(
            children: [
              Text("- Reservado por: ",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(appointment.userFullName)
            ],
          ),
          SizedBox(height: 15),
          appointment.wasAttended
              ? ColoredTag(text: 'Asistido ✅')
              : ColoredTag(text: 'Perdido ❌'),
          SizedBox(height: 5),
          IconButton(
            icon: Icon(Icons.manage_accounts_outlined),
            tooltip: "Actualizar asistencia",
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: Text('¿El cliente asistió al turno?'),
                actions: [
                  TextButton(
                    child: Text('No'),
                    onPressed: () {
                      appointment.wasAttended = false;
                      updateAttendance(appointment);
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Asistencia actualizada')));
                    },
                  ),
                  TextButton(
                    child: Text('Sí'),
                    onPressed: () {
                      appointment.wasAttended = true;
                      updateAttendance(appointment);
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Asistencia actualizada')));
                    },
                  ),
                ],
              ),
            ),
          ),
        ]));
  }
}
