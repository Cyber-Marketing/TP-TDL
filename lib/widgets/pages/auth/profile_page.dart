import 'package:flutter/material.dart';
import 'package:web_app/domain/app_user.dart';
import 'package:web_app/widgets/app_bar/non_home/non_home_app_bar.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({
    super.key,
    required this.user,
  });

  final AppUser user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NonHomeAppBar(context, text: "Mi perfil"),
      backgroundColor: Theme.of(context).colorScheme.onError,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
          ),
          Icon(Icons.face_outlined, size: 200),
          Text("${user.name} ${user.lastName}", style: TextStyle(fontSize: 50)),
          SizedBox(height: 20),
          Text("Rol: ${user.role}"),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.email),
            SizedBox(
              width: 5,
            ),
            Text(user.email)
          ]),
        ],
      )),
    );
  }
}
