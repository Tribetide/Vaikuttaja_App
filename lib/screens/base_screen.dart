import 'package:flutter/material.dart';

/// BaseScreen = yhteinen kehys ShellScreenin välilehdille.
///
/// Vastuut:
/// - piirtää yläbannerin (otsikko + actions)
/// - tarjoaa yhtenäisen paddingin sisällölle
/// - pitää taustan yhtenäisenä (ei valkoisia pintoja)
class BaseScreen extends StatelessWidget {
  const BaseScreen({
    super.key,
    required this.title,
    required this.child,
    this.actions = const [],
    this.padding = const EdgeInsets.all(16),
  });

  final String title;
  final Widget child;
  final List<Widget> actions;

  /// Sisällön padding. MVP:ssä 16 toimii hyvin.
  /// todo: jos haluat “ei reunoja” myös sisällöissä, vaihda EdgeInsets.zero.
  final EdgeInsetsGeometry padding;

  static const double headerHeight = 68;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        // Header / banneri
        Material(
          elevation: 1,
          color: cs.secondary,
          child: SizedBox(
            height: headerHeight,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: textTheme.titleMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  ...actions,
                ],
              ),
            ),
          ),
        ),

        // Sisältöalue: sama tausta kuin koko sovelluksessa (ei valkoista)
        Expanded(
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            padding: padding,
            child: child,
          ),
        ),
      ],
    );
  }
}
