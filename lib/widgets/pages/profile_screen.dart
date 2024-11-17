import 'package:flutter/material.dart';
import 'package:web_app/domain/app_user.dart';
import 'package:web_app/widgets/buttons/app_bar_button.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({
    super.key,
    required this.user,
  });

  final AppUser user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mi perfil",
            style: const TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold)),
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        toolbarHeight: 80,
        leadingWidth: 75,
        leading: AppBarButton(
          tooltip: "Atrás",
          icon: Icons.west,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
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
