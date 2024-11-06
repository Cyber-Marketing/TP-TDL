import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/app_state.dart';
import 'package:web_app/domain/appointment.dart';
import 'package:web_app/widgets/buttons/app_bar_button.dart';

class TakeTurnPage extends StatefulWidget {
  TakeTurnPage({
    super.key,
    required this.appointment,
  });

  final Appointment appointment;

  @override
  State<TakeTurnPage> createState() => _TakeTurnPageState();
}

class _TakeTurnPageState extends State<TakeTurnPage> {
  DateTime dayTurn = DateTime.now();
  String timeTurn = "";

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    widget.appointment.setSchedules();
    var newSchedules = widget.appointment.schedules.keys.toList();
    newSchedules.add("");

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
                    FontWeight.normal)
              ],
            ),
            Row(
              children: [
                _formatText("Horario comercial:  ", FontWeight.bold),
                _formatText(
                    "${widget.appointment.timeRange.start.hour}:${widget.appointment.timeRange.start.minute}hs - ${widget.appointment.timeRange.end.hour}:${widget.appointment.timeRange.end.minute}hs",
                    FontWeight.normal)
              ],
            ),
            Row(
              children: [
                _formatText("Duracion:  ", FontWeight.bold),
                _formatText(
                    "${widget.appointment.serviceDuration.toString().substring(0, widget.appointment.serviceDuration.toString().indexOf("."))}hs",
                    FontWeight.normal)
              ],
            ),
            Row(
              children: [
                _formatText("Seleccione el día:  ", FontWeight.bold),
                IconButton(
                  onPressed: () async {
                    DateTime? newTimeTurn = await showDatePicker(
                        context: context,
                        initialDate: dayTurn,
                        firstDate: widget.appointment.timeRange.start,
                        lastDate: widget.appointment.timeRange.end,
                        helpText: "Seleccione el día");
                    if (newTimeTurn != null) {
                      setState(() {
                        dayTurn = newTimeTurn;
                      });
                    }
                  },
                  icon: const Icon(Icons.calendar_month),
                ),
                Text("${dayTurn.day} - ${dayTurn.month} - ${dayTurn.year}"),
              ],
            ),
            Row(
              children: [
                _formatText("Seleccione el horario:  ", FontWeight.bold),
                DropdownButton<String>(
                  value: timeTurn,
                  icon: const Icon(Icons.timer),
                  style: TextStyle(color: Colors.black),
                  items: newSchedules
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                        value: value, child: Text(value));
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      timeTurn = newValue!;
                    });
                  },
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                appState.bookAppointment(widget.appointment);
                Navigator.pop(context);
              },
              icon: Icon(Icons.done_outline_sharp),
              tooltip: "Confirmar",
              alignment: Alignment.centerLeft,
              color: Colors.black,
              iconSize: 100,
            ),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
    );
  }

  Text _formatText(String text, FontWeight format) => Text(text,
      style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: format));
}
