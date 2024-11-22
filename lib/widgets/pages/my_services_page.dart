import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/app_state.dart';
import 'package:web_app/data/service_repository.dart';
import 'package:web_app/domain/service.dart';
import 'package:web_app/widgets/cards/service_card.dart';
import 'package:web_app/widgets/section_title.dart';

class MyServicesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String userUid = context.watch<AppState>().currentUser!.uid;

    return FutureBuilder(
      future: ServicesRepository().getServicesByUser(userUid),
      builder: ((context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        var services = snapshot.data!.docs.map((docSnapshot) {
          var serviceMap = docSnapshot.data() as Map;
          serviceMap['uid'] = docSnapshot.id;
          return Service.fromMap(serviceMap);
        }).toList();

        String pluralSuffix = services.length > 1 ? 's' : '';
        String sectionTitle = services.isEmpty
            ? 'No has creado ningún servicio aún'
            : 'Tenés ${services.length} servicio$pluralSuffix creado$pluralSuffix:';

        return ListView(
          padding: EdgeInsets.all(30),
          children: [
            SectionTitle(text: sectionTitle),
            for (var service in services)
              ServiceCard(
                service: service,
              )
          ],
        );
      }),
    );
  }
}
