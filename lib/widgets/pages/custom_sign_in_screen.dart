// import 'package:firebase_ui_auth/firebase_ui_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// class CustomSignInScreen extends StatelessWidget {
//   const CustomSignInScreen({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SignInScreen(
//       footerBuilder: (context, action) {
//         return const Padding(
//           padding: EdgeInsets.only(top: 16),
//           child: Center(
//             child: Text(
//               'By signing in, you agree to our terms and conditions.',
//               style: TextStyle(color: Colors.grey),
//             ),
//           ),
//         );
//       },
//       actions: [
//         AuthStateChangeAction(((context, state) {
//           final user = switch (state) {
//             SignedIn state => state.user,
//             UserCreated state => state.credential.user,
//             _ => null
//           };
//           if (user == null) {
//             return;
//           }
//           if (state is UserCreated) {
//             user.updateDisplayName(user.email!.split('@')[0]);
//           }
//           if (!user.emailVerified) {
//             user.sendEmailVerification();
//             const snackBar = SnackBar(
//                 content: Text(
//                     'Please check your email to verify your email address'));
//             ScaffoldMessenger.of(context).showSnackBar(snackBar);
//           }
//           context.goNamed('home');
//         })),
//       ],
//     );
//   }
// }
