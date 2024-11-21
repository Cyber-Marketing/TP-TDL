import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/app_state.dart';
import 'package:web_app/data/service_repository.dart';
import 'package:web_app/domain/service.dart';
import 'package:web_app/widgets/cards/appointable_service_card.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final Stream _servicesStream = ServicesRepository().getServicesStream();

  @override
  Widget build(BuildContext context) {
    AppState appState = context.watch<AppState>();

    return StreamBuilder(
      stream: _servicesStream,
      builder: (BuildContext context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        var servicesCards = snapshot.data?.docs
            .map((serviceDoc) {
              try {
                return AppointableServiceCard(
                  showButton: appState.userIsCustomer(),
                  service: Service.fromMap(serviceDoc.data()!),
                );
              } catch (e) {
                print('Error creating Service: $e');
                return null;
              }
            })
            .where((card) => card != null)
            .cast<AppointableServiceCard>()
            .toList();
        return GridView.count(
          padding: const EdgeInsets.all(50),
          crossAxisCount: 3,
          crossAxisSpacing: 30,
          mainAxisSpacing: 50,
          childAspectRatio: 2,
          children: servicesCards,
        );
      },
    );
  }
}
