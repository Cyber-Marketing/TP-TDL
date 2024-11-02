import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/app_state.dart';
// import 'widgets/pages/home_page.dart';
import 'package:web_app/router.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ChangeNotifierProvider(
    create: (context) => AppState(),
    builder: ((context, child) => const App()),
  ));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'App Turnos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 34, 255, 181)),
      ),
      routerConfig: router,
    );
  }
}
