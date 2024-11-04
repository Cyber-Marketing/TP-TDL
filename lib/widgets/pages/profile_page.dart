import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ProfileScreen(
      providers: const [],
      actions: [
        SignedOutAction((context) {
          context.goNamed('home');
        }),
      ],
    );
  }
}
