import 'package:flutter/material.dart';
import 'package:web_app/widgets/app_bar/non_home/non_home_app_bar_title.dart';
import 'package:web_app/widgets/app_bar/non_home/go_backwards_button.dart';

class NonHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  NonHomeAppBar.private({
    super.key,
    required this.appBar,
  });

  final AppBar appBar;

  factory NonHomeAppBar(context, {text}) {
    AppBar appBar = AppBar(
      backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      toolbarHeight: 80,
      leadingWidth: 75,
      leading: GoBackwardsButton(),
      title: NonHomeAppBarTitle(title: text),
    );
    return NonHomeAppBar.private(appBar: appBar);
  }

  @override
  Widget build(BuildContext context) {
    return appBar;
  }

  @override
  Size get preferredSize => appBar.preferredSize;
}
