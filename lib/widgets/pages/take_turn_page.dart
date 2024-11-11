import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/app_state.dart';
import 'package:web_app/domain/appointment.dart';
import 'package:web_app/domain/made_appointment.dart';
import 'package:web_app/widgets/buttons/app_bar_button.dart';

class TakeTurnPage extends StatefulWidget {
  TakeTurnPage({
    super.key,
    required this.appointment,
  });

  final Appointment appointment;

  @override
  State<TakeTurnPage> createState() => TakeTurnPageState();
}

class TakeTurnPageState extends State<TakeTurnPage> {
  DateTime serviceDay = DateTime.now();
  String serviceTime = "";

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    var completeSchedules = widget.appointment.createSchedules();
    var newSchedules = completeSchedules.keys.toList();
    newSchedules.add("");

    Column description() {
      return Column(
        children: [
          Row(
            children: [
              _formatText("Descripción:  ", FontWeight.bold),
              _formatText(
                  widget.appointment.serviceDescription, FontWeight.normal),
            ],
          ),
          Row(
            children: [
              _formatText("Precio:  ", FontWeight.bold),
              _formatText(
                  "\$${widget.appointment.servicePrice.toStringAsFixed(2)}",
                  FontWeight.normal),
            ],
          ),
          Row(
            children: [
              _formatText("Horario comercial:  ", FontWeight.bold),
              _formatText(
                  "${widget.appointment.timeRange.start.hour}:${widget.appointment.timeRange.start.minute}hs - ${widget.appointment.timeRange.end.hour}:${widget.appointment.timeRange.end.minute}hs",
                  FontWeight.normal),
            ],
          ),
          Row(
            children: [
              _formatText("Duracion:  ", FontWeight.bold),
              _formatText(
                  "${widget.appointment.serviceDuration.toString().substring(0, widget.appointment.serviceDuration.toString().indexOf("."))}hs",
                  FontWeight.normal),
            ],
          ),
        ],
      );
    }

    Row newServiceDayButton() {
      return Row(
        children: [
          _formatText("Seleccione el día:  ", FontWeight.bold),
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
          Text("${serviceDay.day}/${serviceDay.month}/${serviceDay.year}"),
        ],
      );
    }

    Row newServiceTimeButton() {
      return Row(
        children: [
          _formatText("Seleccione el horario:  ", FontWeight.bold),
          DropdownButton<String>(
            value: serviceTime,
            icon: const Icon(Icons.timer),
            style: TextStyle(color: Colors.black),
            items: newSchedules.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(value: value, child: Text(value));
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                serviceTime = newValue!;
              });
            },
          ),
        ],
      );
    }

    IconButton madeAppointment() {
      return IconButton(
        onPressed: () {
          late String menssage;
          if (serviceTime != "") {
            if (_authorization(appState.appointments,
                completeSchedules[serviceTime]!, serviceDay)) {
              appState.bookAppointment(MadeAppointment(
                  widget.appointment.businessName,
                  widget.appointment.serviceDescription,
                  widget.appointment.servicePrice,
                  serviceDay,
                  completeSchedules[serviceTime]!,
                  widget.appointment.serviceDuration));
              menssage = 'Turno reservado';
              Navigator.pop(context);
            } else {
              menssage = 'Se superponen horarios';
            }
          } else {
            menssage = 'Lo siento, faltan realizar selecciones';
          }
          var snackBar = SnackBar(content: Text(menssage));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        icon: Icon(Icons.done_outline_sharp),
        tooltip: "Confirmar",
        alignment: Alignment.centerLeft,
        color: Colors.black,
        iconSize: 100,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appointment.businessName,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold)),
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        toolbarHeight: 80,
        leadingWidth: 75,
        leading: AppBarButton(
          tooltip: "Atrás",
          icon: Icons.west,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          children: [
            description(),
            newServiceDayButton(),
            newServiceTimeButton(),
            madeAppointment(),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
    );
  }

  Text _formatText(String text, FontWeight format) => Text(text,
      style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: format));

  bool _authorization(List<MadeAppointment> appointments,
      (TimeOfDay, TimeOfDay) serviceTime, DateTime serviceDay) {
    var (startServiceTime, endServiceTime) = serviceTime;
    for (var appointment in appointments) {
      if (appointment.serviceDay.year == serviceDay.year &&
          appointment.serviceDay.month == serviceDay.month &&
          appointment.serviceDay.day == serviceDay.day) {
        var (startAppointment, endAppointment) = appointment.serviceTime;
        if (startServiceTime.isAtSameTimeAs(endAppointment) ||
            startServiceTime.isAfter(endAppointment)) {
          continue;
        } else if (endServiceTime.isAtSameTimeAs(startAppointment) ||
            endServiceTime.isBefore(startAppointment)) {
          continue;
        } else {
          return false;
        }
      }
    }
    return true;
  }
}
