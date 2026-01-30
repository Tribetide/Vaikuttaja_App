import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    this.title, // MUUTOS: nullable
    required this.body,
    this.actions,
    this.padding = const EdgeInsets.all(16),
    this.showAppBar = true, // UUSI
  });

  final String? title;
  final Widget body;
  final List<Widget>? actions;
  final EdgeInsetsGeometry padding;
  final bool showAppBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar
          ? AppBar(
              title: Text(title ?? ''),
              actions: actions,
            )
          : null,
      body: Padding(
        padding: padding,
        child: body,
      ),
    );
  }
}
