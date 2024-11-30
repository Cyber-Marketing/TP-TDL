import 'package:flutter/material.dart';
import 'package:web_app/routing/custom_page_route.dart';
import 'package:web_app/widgets/pages/services/new_service_page.dart';

class NewServiceButton extends StatelessWidget {
  const NewServiceButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: () => Navigator.push(
            context, CustomPageRoute(pageWidget: NewServicePage())),
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        child: Icon(Icons.post_add,
            color: Theme.of(context).colorScheme.surfaceBright));
  }
}
