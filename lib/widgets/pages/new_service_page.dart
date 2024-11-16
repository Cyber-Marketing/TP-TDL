import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:web_app/data/service_repository.dart';
import 'package:web_app/domain/service.dart';
import 'package:web_app/widgets/buttons/app_bar_button.dart';
import 'package:web_app/widgets/custom_number_field.dart';
import 'package:web_app/widgets/custom_text_field.dart';

class NewServicePage extends StatefulWidget {
  @override
  State<NewServicePage> createState() => _NewServicePageState();
}

class _NewServicePageState extends State<NewServicePage> {
  final formKey = GlobalKey<FormState>();
  late String businessName;
  late String description;
  late String category;
  late double duration;
  late double price;

  @override
  Widget build(BuildContext context) {
    var loaderOverlay = context.loaderOverlay;

    return LoaderOverlay(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
          toolbarHeight: 80,
          leadingWidth: 75,
          leading: AppBarButton(
            tooltip: "Atrás",
            icon: Icons.west,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        body: Center(
          child: Form(
              key: formKey,
              child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                    Text(
                      "Nombre del negocio",
                    ),
                    CustomTextField(onChanged: (value) => businessName = value),
                    Text(
                      "Descripción",
                    ),
                    CustomTextField(onChanged: (value) => description = value),
                    Text(
                      "Categoría",
                    ),
                    CustomTextField(onChanged: (value) => category = value),
                    Text(
                      "Duración del servicio (en minutos)",
                    ),
                    CustomNumberField(
                        onChanged: (value) => duration = double.parse(value)),
                    Text(
                      "Precio del servicio (en pesos \$)",
                    ),
                    CustomNumberField(
                        onChanged: (value) => price = double.parse(value)),
                    SizedBox(height: 10),
                    ElevatedButton(
                      child: Text('Crear'),
                      onPressed: () async {
                        if (!formKey.currentState!.validate()) return;
                        var service = Service(
                            businessName: businessName,
                            description: description,
                            category: category,
                            duration: duration,
                            price: price);
                        loaderOverlay.show();
                        ServiceRepository().save(service);
                        loaderOverlay.hide();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Servicio creado con éxito ✅")));
                        Navigator.pop(context);
                      },
                    )
                  ]))),
        ),
      ),
    );
  }
}
