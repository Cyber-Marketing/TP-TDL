import 'package:flutter/material.dart';

void main() => runApp(const Aplicaccion());

class Aplicaccion extends StatelessWidget {
  const Aplicaccion({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Servicio de Turnos",
      debugShowCheckedModeBanner: false,
      home: HomePage(titulo: "Home"),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? llave, this.titulo}) : super(key: llave);

  final String? titulo;

  @override
  StateHomePage createState() => StateHomePage();
}

class StateHomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarHomePage(context),
      drawer: menu(),
      body: Center(
        child: formatText('Todos los Turnos'),
      ),
      backgroundColor: const Color.fromARGB(255, 181, 241, 186),
    );
  }
}

Text formatText(String text) => Text(text,
    style: const TextStyle(
        color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold));

void myTurns(BuildContext context) {
  Navigator.push(context, MaterialPageRoute<void>(
    builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: formatText('Mis Turnos'),
          backgroundColor: const Color.fromARGB(255, 93, 135, 212),
        ),
        body: const Center(
          child: Text('Todos mis turnos'),
        ),
        backgroundColor: const Color.fromARGB(255, 113, 192, 120),
      );
    },
  ));
}

AppBar appBarHomePage(BuildContext context) {
  return AppBar(
    title: formatText('Turnos'),
    backgroundColor: const Color.fromARGB(255, 93, 135, 212),
    actions: [
      IconButton(
        icon: const Icon(
          Icons.folder_copy,
          color: Colors.black,
        ),
        tooltip: 'Mis turnos',
        onPressed: () {
          myTurns(context);
        },
      ),
    ],
  );
}

Drawer menu() {
  return Drawer(
    backgroundColor: const Color.fromARGB(255, 82, 202, 206),
    child: Column(
      children: [
        formatText("Menú"),
        Row(
          children: [
            formatText("Mi Cuenta"),
            const IconButton(
              onPressed: null,
              icon: Icon(
                Icons.account_circle_rounded,
                color: Colors.black,
              ),
              tooltip: "Cuenta",
            ),
          ],
        ),
        Row(
          children: [
            formatText("Cerrar Sesión"),
            const IconButton(
              onPressed: null,
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.black,
              ),
              tooltip: "Salir",
            ),
          ],
        ),
      ],
    ),
  );
}
