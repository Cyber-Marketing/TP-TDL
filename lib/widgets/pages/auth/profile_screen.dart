import 'package:flutter/material.dart';
import 'package:web_app/domain/app_user.dart';
import 'package:web_app/widgets/non_home_app_bar.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({
    super.key,
    required this.user,
  });

  final AppUser user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NonHomeAppBar(context, text: "Mi perfil"),
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Tu perfil"),
          Text("${user.name} ${user.lastName}"),
          Text(user.email),
          Text(user.role),
        ],
      )),
    );
  }
}
