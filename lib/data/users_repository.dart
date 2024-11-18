import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:web_app/domain/app_user.dart';

class UsersRepository {
  CollectionReference collection =
      FirebaseFirestore.instance.collection('users');

  UsersRepository();

  save(AppUser user) async {
    collection
        .add(user.toMap())
        .then((value) => print("User profile saved successfully!"))
        .catchError((error) => print("Failed to save user: $error"));
    return;
  }
}
