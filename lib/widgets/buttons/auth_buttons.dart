import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/app_state.dart';
import 'package:web_app/custom_page_route.dart';
import 'package:web_app/domain/app_user.dart';
import 'package:web_app/widgets/buttons/app_bar_button.dart';
import 'package:web_app/widgets/pages/auth/profile_screen.dart';
import 'styled_button.dart';

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
    AppUser? user = context.watch<AppState>().currentUser;

    return Row(
      children: [
        StyledButton(onPressed: () => signOut(), text: 'Cerrar sesión'),
        Visibility(
          visible: isSignedIn,
          child: AppBarButton(
              tooltip: "Perfil",
              icon: Icons.account_circle,
              onPressed: () => Navigator.push(
                  context,
                  CustomPageRoute(
                      pageWidget: ProfileScreen(
                    user: user!,
                  )))),
        )
      ],
    );
  }
}
