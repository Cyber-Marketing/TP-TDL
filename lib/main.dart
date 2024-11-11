import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/app_state.dart';
import 'package:web_app/domain/app_user.dart';
import 'package:web_app/settings/firebase_options.dart';
import 'package:web_app/widgets/custom_auth/login_screen.dart';
import 'package:web_app/widgets/custom_auth/profile_screen.dart';
import 'package:web_app/widgets/custom_auth/registration_screen.dart';
import 'package:web_app/widgets/pages/auth_gate.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(ChangeNotifierProvider(
    create: (context) => AppState(),
    builder: ((context, child) => App()),
  ));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    AppUser? user = context.watch<AppState>().currentUser;

    return MaterialApp(
      title: 'App Turnos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 34, 255, 181)),
      ),
      initialRoute: '',
      routes: {
        '': (context) => AuthGate(),
        'registration_screen': (context) => RegistrationScreen(),
        'login_screen': (context) => LoginScreen(),
        'profile_screen': (context) => ProfileScreen(
              user: user!,
            )
      },
    );
  }
}
