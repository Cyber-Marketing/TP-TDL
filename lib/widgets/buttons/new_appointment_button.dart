import 'package:flutter/material.dart';
import 'package:web_app/widgets/pages/new_service_page.dart';

class NewServiceButton extends StatelessWidget {
  const NewServiceButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => NewServicePage())),
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        child: Icon(Icons.post_add,
            color: Theme.of(context).colorScheme.surfaceBright));
  }
}
