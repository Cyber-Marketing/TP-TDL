import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:web_app/domain/service.dart';

class ServicesRepository {
  CollectionReference<Map<String, dynamic>> collection =
      FirebaseFirestore.instance.collection('services');

  ServicesRepository();

  save(Service service) async {
    collection.add(service.toMap()).then((value) => service.uid = value.id);
    return;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getServicesStream() {
    return collection.snapshots();
  }

  Future<QuerySnapshot<Object?>> getServicesByUser(String userUid) async {
    return await collection.where('ownerUid', isEqualTo: userUid).get();
  }

  Future<void> delete(String serviceUid) async {
    await collection.doc(serviceUid).delete();
  }

  Future<List<String>> getBusinessNamesByUserUid(String userUid) async {
    QuerySnapshot querySnapshot =
        await collection.where('ownerUid', isEqualTo: userUid).get();
    List<String> businessNames = [];
    for (DocumentSnapshot document in querySnapshot.docs) {
      businessNames.add(await document.get('businessName'));
    }
    return businessNames;
  }
}
