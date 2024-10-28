import 'dart:math';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_name_generator/random_name_generator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 34, 255, 181)),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class Appointment {
  Appointment();

  var businessName = RandomNames(Zone.spain).name();
  var serviceDescription = RandomNames(Zone.spain).surname();
  DateTimeRange timeRange = DateTimeRange(
    start: DateTime(
      2024,
      1,
      30,
      10,
    ),
    end: DateTime(
      2024,
      1,
      30,
      10,
    ),
  );
  double servicePrice = Random().nextDouble() * 100;
}

class MyAppState extends ChangeNotifier {
  var appointments = <Appointment>[];
  bool isLoggedIn = false;

  void bookAppointment(Appointment appointment) {
    if (!appointments.contains(appointment)) {
      appointments.add(appointment);
    }
    notifyListeners();
  }

  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = MainPage();
      case 1:
        page = MyAppointmentsPage();
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.onSecondary,
          toolbarHeight: 80,
          title: Row(
            children: [
              SizedBox(width: 25),
              IconButton(
                  tooltip: "Inicio",
                  onPressed: () {
                    setState(() {
                      selectedIndex = 0;
                    });
                  },
                  icon: const Icon(Icons.home)),
              SizedBox(width: 25),
              IconButton(
                  onPressed: () {
                    setState(() {
                      selectedIndex = 1;
                    });
                  },
                  tooltip: "Mis turnos",
                  icon: const Icon(Icons.event)),
            ],
          ),
        ),
        body: Expanded(
          child: Container(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: page,
          ),
        ),
      );
    });
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // var appState = context.watch<MyAppState>();
    // var pair = appState.current;

    // IconData icon;
    // if (appState.favorites.contains(pair)) {
    //   icon = Icons.favorite;
    // } else {
    //   icon = Icons.favorite_border;
    // }

    return GridView.count(
      padding: const EdgeInsets.all(50),
      crossAxisCount: 3,
      crossAxisSpacing: 30,
      mainAxisSpacing: 50,
      childAspectRatio: 2,
      children: [
        for (int i = 0; i < 50; i++)
          AppointmentCard(
            appointment: Appointment(),
          )
      ],
    );
  }
}

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({
    super.key,
    required this.appointment,
  });

  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Container(
      color: Theme.of(context).colorScheme.inversePrimary,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Negocio: ${appointment.businessName}\nDescripcion: ${appointment.serviceDescription}\nPrecio: ${appointment.servicePrice.toStringAsFixed(2)}",
            style: TextStyle(fontSize: 20),
          ),
          IconButton(
              iconSize: 30,
              onPressed: () {
                appState.bookAppointment(appointment);
              },
              icon: const Icon(Icons.book))
        ],
      )),
    );
  }
}

class MyAppointmentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    if (appState.appointments.isEmpty) {
      return ListView(children: [
        Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'No reservaste ningún turno aún',
              style: TextStyle(
                  fontSize: 30, color: const Color.fromARGB(255, 8, 63, 49)),
            ))
      ]);
    }

    int totalAppointments = appState.appointments.length;

    return ListView(
      children: [
        Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
                'Tenés $totalAppointments turno${totalAppointments > 1 ? 's' : ''}:',
                style: TextStyle(
                    fontSize: 60,
                    color: const Color.fromARGB(255, 8, 63, 49)))),
        for (var appointment in appState.appointments)
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(
                "${appointment.businessName}\n${appointment.serviceDescription}"),
          ),
      ],
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!
        .copyWith(color: theme.colorScheme.onPrimary, fontSize: 100);

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          pair.asPascalCase,
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}
