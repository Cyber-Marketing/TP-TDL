import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:web_app/domain/service.dart';

class ServiceRepository {
  FirebaseFirestore database = FirebaseFirestore.instance;

  ServiceRepository();

  save(Service service) async {
    CollectionReference services = database.collection('availableServices');
    var serviceMap = service.toMap();
    services
        .add(serviceMap)
        .then((value) => print("Service created successfully!"))
        .catchError((error) => print("Failed to create service: $error"));
    return;
  }
}
