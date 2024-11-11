import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:flutter/material.dart';
import 'package:web_app/domain/app_user.dart';
import 'package:web_app/domain/made_appointment.dart';

class AppState extends ChangeNotifier {
  AppState() {
    init();
  }

  AppUser? _currentUser;
  AppUser? get currentUser => _currentUser;
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
  List<MadeAppointment> appointments = [];

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

  void bookAppointment(MadeAppointment appointment) {
    if (!appointments.contains(appointment)) {
      appointments.add(appointment);
    }
    notifyListeners();
  }

  bool userIsCustomer() =>
      _currentUser != null ? _currentUser!.isCustomer() : false;
}
