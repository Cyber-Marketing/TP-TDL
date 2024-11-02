import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:web_app/widgets/buttons/app_bar_button.dart';
import 'tutorial.dart';

class AuthButtons extends StatelessWidget {
  const AuthButtons({
    super.key,
    required this.isSignedIn,
    required this.signOut,
  });

  final bool isSignedIn;
  final void Function() signOut;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StyledButton(
            onPressed: () {
              !isSignedIn ? context.goNamed('sign-in') : signOut();
            },
            child: !isSignedIn
                ? const Text('Iniciar sesión')
                : const Text('Cerrar sesión')),
        Visibility(
          visible: isSignedIn,
          child: AppBarButton(
              tooltip: "Perfil",
              icon: Icons.account_circle,
              onPressed: () => context.goNamed('profile')),
        )
      ],
    );
  }
}
