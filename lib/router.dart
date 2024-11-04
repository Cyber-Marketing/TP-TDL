import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:web_app/widgets/pages/auth_gate.dart';
import 'package:web_app/widgets/pages/profile_page.dart';

CustomTransitionPage buildPageWithoutAnimation({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          child);
}

final router = GoRouter(
  routes: [
    GoRoute(
      name: 'home',
      path: '/',
      builder: (context, state) => AuthGate(),
      routes: [
        GoRoute(
          name: 'forgot-password',
          path: 'forgot-password',
          pageBuilder: (context, state) => buildPageWithoutAnimation(
              context: context,
              state: state,
              child: ForgotPasswordScreen(
                email: state.uri.queryParameters['email'],
                headerMaxExtent: 200,
              )),
        ),
        GoRoute(
          name: 'profile',
          path: 'profile',
          pageBuilder: (context, state) => buildPageWithoutAnimation(
              context: context, state: state, child: ProfilePage()),
        ),
      ],
    ),
  ],
);
