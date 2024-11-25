import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/app_state.dart';
import 'package:web_app/data/appointment_database.dart';
import 'package:web_app/domain/appointment.dart';
import 'package:web_app/domain/service.dart';
import 'package:web_app/widgets/non_home_app_bar.dart';

class MakeAppointmentPage extends StatefulWidget {
  MakeAppointmentPage({
    super.key,
    required this.service,
  });

  final Service service;

  @override
  State<MakeAppointmentPage> createState() => MakeAppointmentPageState();
}

class MakeAppointmentPageState extends State<MakeAppointmentPage> {
  DateTime serviceDay =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  String serviceTime = "Elegí una opción";

  @override
  Widget build(BuildContext context) {
    var userUid = context.watch<AppState>().currentUser!.uid;
    var completeSchedules = widget.service.createSchedules();
    List<String> newSchedules = [""];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      appBar: NonHomeAppBar(context, text: "Reservar turno"),
      body: FutureBuilder(
        future: getUserAppointments(userUid),
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var appointments = snapshot.data!.docs
              .map((snapshotDoc) {
                try {
                  var appointmentMap = snapshotDoc.data();
                  appointmentMap['uid'] = snapshotDoc.id;
                  return Appointment.fromMap(appointmentMap);
                } catch (e) {
                  print('Error creating appointment: $e');
                  return null;
                }
              })
              .where((appointment) => appointment != null)
              .cast<Appointment>()
              .toList();
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.service.businessName),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  "Descripción: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(widget.service.description)
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  "Precio: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("\$${widget.service.price.toStringAsFixed(2)}")
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  "Horario comercial: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                    "${widget.service.timeRange.start.hour}:${widget.service.timeRange.start.minute}hs - ${widget.service.timeRange.end.hour}:${widget.service.timeRange.end.minute}hs")
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  "Duración del servicio: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                    "${widget.service.getDuration().toString().substring(0, widget.service.getDuration().toString().indexOf("."))}hs")
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.calendar_month),
                    onPressed: () async {
                      DateTime? newServiceTime = await showDatePicker(
                          context: context,
                          initialDate: serviceDay,
                          firstDate: widget.service.timeRange.start,
                          lastDate: widget.service.timeRange.end,
                          helpText: "Seleccione el día");
                      if (newServiceTime != null) {
                        setState(() {
                          serviceDay = newServiceTime;
                        });
                      }
                    },
                  ),
                  Text(
                      "${serviceDay.day}/${serviceDay.month}/${serviceDay.year}"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Seleccione el horario: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  FutureBuilder<List<String>>(
                      future: getFreeAppointments(completeSchedules,
                          widget.service.businessName, serviceDay, DateTime.now()),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        newSchedules = snapshot.data!;
                        return DropdownButton<String>(
                          value: serviceTime,
                          icon: const Icon(Icons.timer),
                          style: TextStyle(color: Colors.black),
                          items: newSchedules
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                                value: value, child: Text(value));
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              serviceTime = newValue!;
                            });
                          },
                        );
                      }),
                ],
              ),
              IconButton(
                icon: Icon(Icons.done_outline_sharp),
                tooltip: "Confirmar",
                alignment: Alignment.centerLeft,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                onPressed: () async {
                  late String message;
                  if (serviceTime != "Elegí una opción") {
                    if (_authorization(appointments,
                        completeSchedules[serviceTime]!, serviceDay)) {
                      var appointment = Appointment(
                          widget.service.businessName,
                          widget.service.description,
                          widget.service.price,
                          serviceDay,
                          completeSchedules[serviceTime]!);
                      makeAppointment(userUid, appointment);
                      message = 'Turno reservado';
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    } else {
                      message = 'Se superponen horarios!';
                    }
                  } else {
                    message = 'Lo siento, no realizaste una selección o'
                        ' ya no hay más turnos disponibles para esta fecha!';
                  }
                  if (context.mounted) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(message)));
                  }
                },
              )
            ],
          );
        }),
      ),
    );
  }

  bool _authorization(List<Appointment> appointments,
      (TimeOfDay, TimeOfDay) serviceTime, DateTime serviceDay) {
    for (var appointment in appointments) {
      if (appointment.serviceDay.year == serviceDay.year &&
          appointment.serviceDay.month == serviceDay.month &&
          appointment.serviceDay.day == serviceDay.day) {
        if (serviceTime.$1.isAtSameTimeAs(appointment.serviceTime.$2) ||
            serviceTime.$1.isAfter(appointment.serviceTime.$2)) {
          continue;
        } else if (serviceTime.$2.isAtSameTimeAs(appointment.serviceTime.$1) ||
            serviceTime.$2.isBefore(appointment.serviceTime.$1)) {
          continue;
        } else {
          return false;
        }
      }
    }
    return true;
  }
}
