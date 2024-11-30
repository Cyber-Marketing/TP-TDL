import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:web_app/data/appointment_database.dart';
import 'package:web_app/domain/appointment.dart';
import 'package:web_app/widgets/form_fields/custom_text_field.dart';
import 'package:web_app/widgets/app_bar/non_home/non_home_app_bar.dart';

class GiveAppointmentFeedbackPage extends StatefulWidget {
  final Appointment appointment;

  GiveAppointmentFeedbackPage({super.key, required this.appointment});

  @override
  State<GiveAppointmentFeedbackPage> createState() =>
      _GiveAppointmentFeedbackPageState();
}

class _GiveAppointmentFeedbackPageState
    extends State<GiveAppointmentFeedbackPage> {
  final formKey = GlobalKey<FormState>();
  int rating = 1;
  String? comment;
  List<int> options = [1, 2, 3, 4, 5];

  @override
  Widget build(BuildContext context) {
    var loaderOverlay = context.loaderOverlay;

    return LoaderOverlay(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.onError,
        appBar: NonHomeAppBar(context, text: "Dar feedback sobre turno"),
        body: Container(
          margin: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.25,
              horizontal: MediaQuery.of(context).size.width * 0.35),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                width: 1.5),
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
          child: Form(
            key: formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('¿De cuántas estrellas fue tu experiencia?:'),
                      SizedBox(width: 15),
                      DropdownButton(
                        value: rating,
                        items: options.map((int dropDownItem) {
                          return DropdownMenuItem(
                            value: dropDownItem,
                            child: Text(
                              dropDownItem.toString(),
                            ),
                          );
                        }).toList(),
                        onChanged: (newSelectedRating) {
                          setState(() {
                            rating = newSelectedRating!;
                          });
                          print(rating);
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  CustomTextField(
                    hintText: 'Breve comentario...',
                    onChanged: (text) => comment = text,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  ElevatedButton(
                    child: Text('Enviar calificación'),
                    onPressed: () async {
                      String message = 'Feedback enviado exitosamente';
                      loaderOverlay.show();
                      giveAppointmentFeedback(
                              widget.appointment.uid, rating, comment)
                          .catchError((onError) =>
                              message = 'Error al enviar feedback');
                      loaderOverlay.hide();
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(message)));
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
