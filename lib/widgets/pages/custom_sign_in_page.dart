// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_ui_auth/firebase_ui_auth.dart';
// import 'package:flutter/material.dart';

// class CustomSignInPage extends StatelessWidget {
//   const CustomSignInPage({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomEmailSignInForm(),
//     );
//   }
// }

// class CustomEmailSignInForm extends StatelessWidget {
//   CustomEmailSignInForm({super.key});

//   final emailCtrl = TextEditingController();
//   final passwordCtrl = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return AuthFlowBuilder<EmailFlowController>(
//       builder: (context, state, controller, _) {
//         if (state is AwaitingEmailAndPassword) {
//           return Column(
//             children: [
//               TextField(controller: emailCtrl),
//               TextField(controller: passwordCtrl),
//               ElevatedButton(
//                 onPressed: () {
//                   controller.setEmailAndPassword(
//                     emailCtrl.text,
//                     passwordCtrl.text,
//                   );
//                 },
//                 child: const Text('Sign in'),
//               ),
//             ],
//           );
//         } else if (state is SigningIn) {
//           return Center(child: CircularProgressIndicator());
//         } else if (state is AuthFailed) {
//           return ErrorText(exception: state.exception);
//         }
//       },
//     );
//   }
// }
