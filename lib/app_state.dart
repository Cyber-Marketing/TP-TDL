import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:flutter/material.dart';
import 'package:web_app/domain/app_user.dart';
import 'package:web_app/domain/appointment.dart';

class AppState extends ChangeNotifier {
  AppState() {
    init();
  }

  AppUser? currentUser;
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
  List<Appointment> appointments = [];

  Future<void> init() async {
    FirebaseAuth.instance.userChanges().listen((User? user) async {
      currentUser = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: user?.uid)
          .get()
          .then((userDocument) => AppUser.fromMap(userDocument.docs.first));
      _isSignedIn = user != null;
      notifyListeners();
    });
  }

  void bookAppointment(Appointment appointment) {
    if (!appointments.contains(appointment)) {
      appointments.add(appointment);
    }
    notifyListeners();
  }
}
