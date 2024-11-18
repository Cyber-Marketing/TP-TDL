import 'package:flutter/material.dart';
import 'package:web_app/data/service_repository.dart';
import 'package:web_app/domain/service.dart';
import 'package:web_app/widgets/cards/service_card.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final Stream _servicesStream = ServicesRepository().getServicesStream();

  @override
  Widget build(BuildContext context) {
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
                return ServiceCard(
                  service: Service.fromMap(
                      serviceDoc.data()! as Map<String, dynamic>),
                );
              } catch (e) {
                print('Error creating Service: $e');
                return null;
              }
            })
            .where((card) => card != null)
            .cast<ServiceCard>()
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
