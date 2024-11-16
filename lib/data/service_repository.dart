import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:web_app/domain/service.dart';

class ServiceRepository {
  CollectionReference collection =
      FirebaseFirestore.instance.collection('availableServices');

  ServiceRepository();

  save(Service service) async {
    var serviceMap = service.toMap();
    collection
        .add(serviceMap)
        .then((value) => print("Service created successfully!"))
        .catchError((error) => print("Failed to create service: $error"));
    return;
  }

  Stream<QuerySnapshot<Object?>> getServicesStream() {
    return collection.snapshots();
  }
}
