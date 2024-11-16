import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:web_app/domain/service.dart';

class ServiceRepository {
  CollectionReference servicesCollection =
      FirebaseFirestore.instance.collection('availableServices');

  ServiceRepository();

  save(Service service) async {
    var serviceMap = service.toMap();
    servicesCollection
        .add(serviceMap)
        .then((value) => print("Service created successfully!"))
        .catchError((error) => print("Failed to create service: $error"));
    return;
  }
}
