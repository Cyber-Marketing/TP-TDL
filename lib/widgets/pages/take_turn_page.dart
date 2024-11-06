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
  var turn = DateTime.now();

  void callDatePicker() async {
    var selectedDate = await getDatePickerWidget();
    setState(() {
      turn = selectedDate!;
    });
  }

  Future<DateTime?> getDatePickerWidget() {
    return showDatePicker(
        context: context,
        initialDate: turn,
        firstDate: widget.appointment.timeRange.start,
        lastDate: widget.appointment.timeRange.end,
        builder: (context, child) =>
            Theme(data: ThemeData.dark(), child: child!));
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

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
            appState.bookAppointment(widget.appointment);
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
                _formatText("Seleccione el dia:  ", FontWeight.bold),
                IconButton(
                    onPressed: callDatePicker,
                    icon: const Icon(Icons.calendar_month))
              ],
            ),
            Text("$turn"),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
    );
  }

  Text _formatText(String text, FontWeight format) => Text(text,
      style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: format));
}
