import 'package:flutter/material.dart';
import '../theme/app_theme_theme.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({
    super.key,
    required this.title,
    required this.child,
    this.actions = const [],
  });

  final String title;
  final Widget child;
  final List<Widget> actions;

  // Yksi paikka muuttaa bannerin mittoja/tyyliä
  static const double headerHeight = 68;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header / banneri
        Material(
          elevation: 1, // kevyt varjo (vaihda tähän jos haluat)
          color: AppColors.secondary,
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
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.textPrimary),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  ...actions,
                ],
              ),
            ),
          ),
        ),

        // Sisältö
        Expanded(
          child: Container(
            color: AppColors.surface,
            padding: const EdgeInsets.all(16),
            child: child,
          ),
        ),
      ],
    );
  }
}
