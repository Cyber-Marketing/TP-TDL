import 'package:flutter/material.dart';
import 'package:web_app/custom_page_route.dart';
import 'package:web_app/domain/service.dart';
import 'package:web_app/widgets/colored_tag.dart';
import 'package:web_app/widgets/pages/appointments/make_appointment_page.dart';
import 'package:web_app/widgets/pages/appointments/check_feedback_page.dart';

class AppointableServiceCard extends StatelessWidget {
  AppointableServiceCard({
    super.key,
    required this.service,
    required this.showButton,
  });

  final Service service;
  final bool showButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Theme.of(context).colorScheme.inversePrimary,
      ),
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            service.businessName,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text(service.description),
          SizedBox(height: 10),
          ColoredTag(text: service.category),
          SizedBox(height: 20),
          Row(children: [
            Visibility(
              visible: showButton,
              child: Center(
                child: IconButton(
                  tooltip: "Reservar turno",
                  iconSize: 18,
                  icon: const Icon(Icons.bookmarks),
                  onPressed: () {
                    Navigator.push(
                        context,
                        CustomPageRoute(
                            pageWidget: MakeAppointmentPage(service: service)));
                  },
                ),
              ),
            ),
            Visibility(
              visible: showButton,
              child: Center(
                child: IconButton(
                  tooltip: "Ver opiniones",
                  iconSize: 18,
                  icon: const Icon(Icons.forum),
                  onPressed: () {
                    Navigator.push(
                        context,
                        CustomPageRoute(
                            pageWidget: CheckFeedbackPage(service: service)));
                  },
                ),
              ),
            )
          ])
        ],
      ),
    );
  }
}
