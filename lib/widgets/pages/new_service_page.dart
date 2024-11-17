import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:web_app/data/service_repository.dart';
import 'package:web_app/domain/service.dart';
import 'package:web_app/widgets/form_fields/custom_number_field.dart';
import 'package:web_app/widgets/form_fields/custom_text_field.dart';
import 'package:web_app/widgets/non_home_app_bar.dart';

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
        appBar: NonHomeAppBar(context, text: "Crear nuevo servicio"),
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
                    CustomTextField(
                        hintText: "Ingresá el nombre de tu negocio",
                        onChanged: (value) => businessName = value),
                    Text(
                      "Descripción",
                    ),
                    CustomTextField(
                        hintText: "Ingresá el nombre de tu negocio",
                        onChanged: (value) => description = value),
                    Text(
                      "Categoría",
                    ),
                    CustomTextField(
                        hintText: "Ingresá la categoría de tu servicio",
                        onChanged: (value) => category = value),
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
                        ServicesRepository().save(service);
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
