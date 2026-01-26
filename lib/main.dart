import 'package:flutter/material.dart';
import 'package:vaikuttaja_app/theme/app_theme_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vaikuttaja App',
      theme: AppTheme.lightTheme,
      home: const MyHomePage(title: 'Theme Showcase'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Colors Section
            Text('Brand Colors', style: textTheme.displayMedium),
            const SizedBox(height: 16),
            _ColorSwatch(
              label: 'Primary',
              color: colorScheme.primary,
              code: '#5D0066',
            ),
            _ColorSwatch(
              label: 'Secondary',
              color: colorScheme.secondary,
              code: '#C1E0F7',
            ),
            _ColorSwatch(
              label: 'Tertiary (Status)',
              color: colorScheme.tertiary,
              code: '#9D8420',
            ),
            _ColorSwatch(
              label: 'Surface',
              color: colorScheme.surface,
              code: '#FFFFFF',
            ),
            _ColorSwatch(
              label: 'Background',
              color: colorScheme.background,
              code: '#DECED2',
            ),
            _ColorSwatch(
              label: 'Navigation',
              color: AppColors.navigation,
              code: '#F2ECEE',
            ),
            _ColorSwatch(
              label: 'Text Primary',
              color: AppColors.textPrimary,
              code: '#353B3C',
            ),
            const SizedBox(height: 32),

            // Text Styles Section
            Text('Text Styles', style: textTheme.displayMedium),
            const SizedBox(height: 16),
            Text('Display Large', style: textTheme.displayLarge),
            Text('Display Medium', style: textTheme.displayMedium),
            Text('Display Small', style: textTheme.displaySmall),
            const SizedBox(height: 12),
            Text('Headline Medium', style: textTheme.headlineMedium),
            Text('Headline Small', style: textTheme.headlineSmall),
            const SizedBox(height: 12),
            Text('Title Large', style: textTheme.titleLarge),
            const SizedBox(height: 12),
            Text('Body Large', style: textTheme.bodyLarge),
            Text('Body Medium', style: textTheme.bodyMedium),
            Text('Body Small', style: textTheme.bodySmall),
            const SizedBox(height: 12),
            Text('Label Large', style: textTheme.labelLarge),
            const SizedBox(height: 32),

            // Buttons Section
            Text('Buttons', style: textTheme.displayMedium),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () {},
              child: const Text('Filled Button'),
            ),
            const SizedBox(height: 8),
            FilledButton.tonal(
              onPressed: () {},
              child: const Text('Tonal Button'),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () {},
              child: const Text('Outlined Button'),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {},
              child: const Text('Text Button'),
            ),
            const SizedBox(height: 32),

            // Increment Counter for testing
            Text('Counter Test', style: textTheme.displayMedium),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorScheme.secondary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Text('You pressed the button:', style: textTheme.bodyLarge),
                  const SizedBox(height: 8),
                  Text(
                    '$_counter',
                    style: textTheme.displayLarge?.copyWith(
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
class _ColorSwatch extends StatelessWidget {
  final String label;
  final Color color;
  final String code;

  const _ColorSwatch({
    required this.label,
    required this.color,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.grey.shade300,
                width: 1,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 4),
              Text(
                code,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}