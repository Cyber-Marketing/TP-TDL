import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:flutter/material.dart';
import 'package:web_app/domain/appointment.dart';

class AppState extends ChangeNotifier {
  AppState() {
    init();
  }

  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
  List<Appointment> appointments = [];

  Future<void> init() async {
    FirebaseAuth.instance.userChanges().listen((User? user) {
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
