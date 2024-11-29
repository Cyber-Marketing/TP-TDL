import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/app_state.dart';
import 'package:web_app/data/service_repository.dart';
import 'package:web_app/domain/service.dart';
import 'package:web_app/widgets/cards/appointable_service_card.dart';

class MainStreamBuilder extends StatelessWidget {
  final String userUid;
  final String? name;

  MainStreamBuilder({required this.userUid, this.name});

  @override
  Widget build(BuildContext context) {
    bool userIsCustomer = context.watch<AppState>().userIsCustomer();
    return StreamBuilder(
        stream: ServicesRepository().getServicesStream(),
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          var services = snapshot.data!.docs
              .map((docSnapshot) {
                var serviceMap = docSnapshot.data() as Map;
                serviceMap['uid'] = docSnapshot.id;
                return Service.fromMap(serviceMap);
              })
              .where((serv) =>
                  serv.businessName.toLowerCase().contains(name!.toLowerCase()))
              .toList();

          return GridView(
            padding: EdgeInsets.all(50),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 50,
                crossAxisSpacing: 30,
                childAspectRatio: 2,
                crossAxisCount: 3),
            children: [
              for (var service in services)
                AppointableServiceCard(
                  showButton: userIsCustomer,
                  service: service,
                ),
            ],
          );
        });
  }
}
