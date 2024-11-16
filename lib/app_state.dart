import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:flutter/material.dart';
import 'package:web_app/data/service_repository.dart';
import 'package:web_app/domain/app_user.dart';

class AppState extends ChangeNotifier {
  AppState() {
    init();
  }

  ServiceRepository serviceRepository = ServiceRepository();
  AppUser? _currentUser;
  AppUser? get currentUser => _currentUser;
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  Future<void> init() async {
    FirebaseAuth.instance.userChanges().listen((User? user) async {
      _currentUser = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: user?.uid)
          .get()
          .then((userDocument) => AppUser.fromMap(userDocument.docs.first));
      _isSignedIn = user != null;
      notifyListeners();
    });
  }

  bool userIsCustomer() =>
      _currentUser != null ? _currentUser!.isCustomer() : false;
}
