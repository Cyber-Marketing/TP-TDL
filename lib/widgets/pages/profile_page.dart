import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:web_app/widgets/buttons/app_bar_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ProfileScreen(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        leadingWidth: 75,
        leading: AppBarButton(
            tooltip: "Atrás",
            icon: Icons.west,
            onPressed: () => context.goNamed('home')),
      ),
      showDeleteConfirmationDialog: true,
      providers: const [],
      actions: [
        SignedOutAction((context) {
          context.goNamed('home');
        }),
      ],
    );
  }
}
