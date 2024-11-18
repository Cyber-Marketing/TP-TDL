import 'package:flutter/material.dart';
import 'package:web_app/widgets/buttons/app_bar_button.dart';

class GoBackwardsButton extends StatelessWidget {
  const GoBackwardsButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBarButton(
      tooltip: "Atrás",
      icon: Icons.west,
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
