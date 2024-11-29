import 'package:flutter/material.dart';
import 'package:web_app/data/service_repository.dart';
import 'package:web_app/domain/service.dart';
import 'package:web_app/widgets/cards/service_card.dart';
import 'package:web_app/widgets/section_title.dart';

class MyServicesStreamBuilder extends StatelessWidget {
  final String userUid;
  final String? name;

  MyServicesStreamBuilder({required this.userUid, this.name});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: ServicesRepository().getServicesStream(),
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          var services = name != null
              ? snapshot.data!.docs
                  .map((docSnapshot) {
                    var serviceMap = docSnapshot.data() as Map;
                    serviceMap['uid'] = docSnapshot.id;
                    return Service.fromMap(serviceMap);
                  })
                  .where((serv) =>
                      serv.ownerUid == userUid &&
                      serv.businessName
                          .toLowerCase()
                          .contains(name!.toLowerCase()))
                  .toList()
              : snapshot.data!.docs
                  .map((docSnapshot) {
                    var serviceMap = docSnapshot.data() as Map;
                    serviceMap['uid'] = docSnapshot.id;
                    return Service.fromMap(serviceMap);
                  })
                  .where((serv) => serv.ownerUid == userUid)
                  .toList();

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
        });
  }
}
