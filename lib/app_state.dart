import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:web_app/domain/app_user.dart';

class AppState extends ChangeNotifier {
  AppState() {
    init();
  }

  AppUser? _currentUser;
  AppUser? get currentUser => _currentUser;
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  Future<void> init() async {
    FirebaseAuth.instance.userChanges().listen((User? user) async {
      _currentUser = await FirebaseFirestore.instance
          .collection('users')
          .doc(user?.uid)
          .get()
          .then((snapshot) => AppUser.fromMap(snapshot.data()));
      _isSignedIn = user != null;
      notifyListeners();
    });
  }

  bool userIsCustomer() =>
      _currentUser != null ? _currentUser!.isCustomer() : false;
}
