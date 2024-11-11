import 'package:flutter/material.dart';
import 'package:web_app/domain/app_user.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({
    super.key,
    required this.user,
  });

  final AppUser user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(user.email),
          Text(user.role),
        ],
      )),
    );
  }
}
