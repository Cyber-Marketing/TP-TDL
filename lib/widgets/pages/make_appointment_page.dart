import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/app_state.dart';
import 'package:web_app/domain/appointment.dart';
import 'package:web_app/data/appointment_database.dart';
import 'package:web_app/domain/made_appointment.dart';
import 'package:web_app/widgets/non_home_app_bar.dart';
import 'package:web_app/data/free_appointments.dart';

class MakeAppointmentPage extends StatefulWidget {
  MakeAppointmentPage({
    super.key,
    required this.appointment,
  });

  final Appointment appointment;

  @override
  State<MakeAppointmentPage> createState() => MakeAppointmentPageState();
}

class MakeAppointmentPageState extends State<MakeAppointmentPage> {
  DateTime serviceDay = DateTime.now();
  String serviceTime = "Elegí una opción";

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    var completeSchedules = widget.appointment.createSchedules();
    List<String> newSchedules = [""];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      appBar: NonHomeAppBar(context, text: "Reservar turno"),
      body: FutureBuilder(
        future: getCustomerAppointment(appState.currentUser!.uid),
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var appointments = snapshot.data!.docs
              .map((appointmentDoc) {
                try {
                  return MadeAppointment.fromMap(appointmentDoc.data());
                } catch (e) {
                  print('Error creating appointment: $e');
                  return null;
                }
              })
              .where((appointment) => appointment != null)
              .cast<MadeAppointment>()
              .toList();
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.appointment.businessName),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  "Descripción: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(widget.appointment.serviceDescription)
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  "Precio: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("\$${widget.appointment.servicePrice.toStringAsFixed(2)}")
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  "Horario comercial: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                    "${widget.appointment.timeRange.start.hour}:${widget.appointment.timeRange.start.minute}hs - ${widget.appointment.timeRange.end.hour}:${widget.appointment.timeRange.end.minute}hs")
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  "Duración del servicio: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                    "${widget.appointment.serviceDuration.toString().substring(0, widget.appointment.serviceDuration.toString().indexOf("."))}hs")
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Seleccione el día: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () async {
                      DateTime? newserviceTime = await showDatePicker(
                          context: context,
                          initialDate: serviceDay,
                          firstDate: widget.appointment.timeRange.start,
                          lastDate: widget.appointment.timeRange.end,
                          helpText: "Seleccione el día");
                      if (newserviceTime != null) {
                        setState(() {
                          serviceDay = newserviceTime;
                        });
                      }
                    },
                    icon: const Icon(Icons.calendar_month),
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
                          widget.appointment.businessName, serviceDay.day),
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
                color: Colors.black,
                onPressed: () async {
                  late String menssage;
                  if (serviceTime != "Elegí una opción") {
                    if (_authorization(appointments,
                        completeSchedules[serviceTime]!, serviceDay)) {
                      int appointmentNumber = appointments.length + 1;
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(appState.currentUser!.uid)
                          .collection("appointments")
                          .add(MadeAppointment(
                                  'appointment$appointmentNumber',
                                  widget.appointment.businessName,
                                  widget.appointment.serviceDescription,
                                  widget.appointment.servicePrice,
                                  serviceDay,
                                  completeSchedules[serviceTime]!)
                              .toMap())
                          .then(
                              (value) => print("Service created successfully!"))
                          .catchError((error) =>
                              print("Failed to create service: $error"));
                      menssage = 'Turno reservado';
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    } else {
                      menssage = 'Se superponen horarios';
                    }
                  } else {
                    menssage = 'Lo siento, faltan realizar selecciones';
                  }
                  if (context.mounted) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(menssage)));
                  }
                },
              )
            ],
          );
        }),
      ),
    );
  }

  bool _authorization(List<MadeAppointment> appointments,
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
