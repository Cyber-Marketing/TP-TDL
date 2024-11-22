import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:web_app/domain/service.dart';

class ServicesRepository {
  CollectionReference collection =
      FirebaseFirestore.instance.collection('services');

  ServicesRepository();

  save(Service service) async {
    collection.add(service.toMap()).then((value) => service.uid = value.id);
    return;
  }

  Stream<QuerySnapshot<Object?>> getServicesStream() {
    return collection.snapshots();
  }

  Future<QuerySnapshot<Object?>> getServicesByUser(String userUid) async {
    return await collection.where('ownerUid', isEqualTo: userUid).get();
  }

  Future<void> delete(String serviceUid) async {
    await collection.doc(serviceUid).delete();
  }
}
