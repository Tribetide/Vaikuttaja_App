import 'package:flutter/material.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/app_section_card.dart';
import 'shell_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _start();
  }

  Future<void> _start() async {
    await Future.delayed(const Duration(milliseconds: 150));
    if (!mounted) return;

    await _controller.forward(); // fade in
    await Future.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return;

    await _controller.reverse(); // fade out
    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const ShellScreen(),
        transitionDuration: const Duration(milliseconds: 350),
        transitionsBuilder: (_, animation, __, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return AppScaffold(
      showAppBar: false,
      padding: EdgeInsets.zero,
      body: Center(
        child: FadeTransition(
          opacity: _fade,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 86,
                  height: 86,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: cs.primary.withAlpha(20),
                  ),
                  child: Icon(Icons.bolt, size: 40, color: cs.primary),
                ),
                const SizedBox(height: 16),
                Text(
                  'Sovelluksen nimi',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 10),

                // Hyödynnetään myös AppSectionCard (yhtenäinen “kortti-ilme”)
                const AppSectionCard(
                  title: 'Tervetuloa',
                  child: Text('Yritykset × Vaikuttajat — selkeä kontaktointialusta.'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
