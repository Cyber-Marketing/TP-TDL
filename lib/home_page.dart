import 'package:flutter/material.dart';
import 'package:web_app/main.dart';

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
