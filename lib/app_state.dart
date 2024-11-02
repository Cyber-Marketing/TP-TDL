import 'package:english_words/english_words.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:web_app/domain/appointment.dart';
import 'package:web_app/settings/firebase_options.dart';

class AppState extends ChangeNotifier {
  AppState() {
    init();
  }

  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
    ]);

    FirebaseAuth.instance.userChanges().listen((user) {
      _isSignedIn = user != null;
      notifyListeners();
    });
  }

  var appointments = <Appointment>[];

  void bookAppointment(Appointment appointment) {
    if (!appointments.contains(appointment)) {
      appointments.add(appointment);
    }
    notifyListeners();
  }

  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}
