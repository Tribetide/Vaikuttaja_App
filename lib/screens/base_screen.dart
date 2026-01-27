import 'package:flutter/material.dart';
import '../theme/app_theme_theme.dart';

// BaseScreen = yhteinen “kehys” kaikille kirjautumisen jälkeisille näkymille.
//
// Miksi tämä on olemassa?
// - Halutaan yksi yhtenäinen paikka, joka piirtää yläbannerin (otsikko + actionit)
// - Halutaan yhdenmukainen padding / taustaväri / layout kaikille sisällöille
// - ShellScreen voi vaihtaa vain title + child + actions, eikä jokaisen tabin
//   tarvitse rakentaa headeria itse.
//
// Käyttö:
// BaseScreen(
//   title: "Feed",
//   actions: [IconButton(...)],
//   child: HomeScreen(),
// )

class BaseScreen extends StatelessWidget {
  const BaseScreen({
    super.key,
    required this.title,
    required this.child,
    this.actions = const [],
  });

  // Bannerissa näytettävä otsikko (esim. "Feed", "Chat", "Oma mediakortti")
  final String title;
  // Varsinainen näkymän sisältö, joka tulee bannerin alle.
  final Widget child;
  // Oikean reunan toimintopainikkeet (esim. “Muokkaa”, “Lisää”, asetukset...).
  // Oletus = ei actioneita.
  final List<Widget> actions;

  // Yksi paikka muuttaa bannerin mittoja/tyyliä
  static const double headerHeight = 68;

  @override
  Widget build(BuildContext context) {
    // Column: yläbanneri + alla sisältö (Expanded täyttää lopun tilan).
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
