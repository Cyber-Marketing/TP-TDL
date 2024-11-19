import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:web_app/domain/service.dart';

class ServicesRepository {
  CollectionReference collection =
      FirebaseFirestore.instance.collection('services');

  ServicesRepository();

  save(Service service) async {
    collection
        .add(service.toMap())
        .then((value) => print("Service created successfully!"))
        .catchError((error) => print("Failed to create service: $error"));
    return;
  }

  Stream<QuerySnapshot<Object?>> getServicesStream() {
    return collection.snapshots();
  }
}
