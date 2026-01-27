import 'package:flutter/material.dart';
import '../models/influencer.dart';

/// ProfileScreen = vaikuttajan mediakortti (katselunäkymä).
///
/// MVP:
/// - näyttää Influencer-datan (jos annettu), muuten fallback-testidataa
/// - osiot kortteina (teema hoitaa ulkoasun)
///
/// todo:
/// - lisää lisää osioita (yleisödata, paketit, portfolio)
/// - kun backend tulee: data provider/repo -> ei tarvitse välittää suoraan Shellistä
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    this.influencer,
  });

  final Influencer? influencer;

  @override
  Widget build(BuildContext context) {
    // MVP: jos Shell ei vielä välitä oikeaa dataa, käytetään fallbackia
    final i = influencer ??
        Influencer(
          id: 'test-user-id',
          name: 'Nimi / Nimimerkki',
          platform: 'Instagram',
          followers: 58000,
          price: 0,
          imageUrl: '',
        );

    const location = 'Seinäjoki'; // todo: tulee user-profiilista myöhemmin

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _HeaderCard(
            name: i.name,
            location: location,
            primaryPlatform: i.platform,
            followers: i.followers,
          ),
          const SizedBox(height: 12),

          const _SectionCard(
            title: 'Minä sisällöntuottajana',
            child: Text('Tekstiä minusta'),
          ),
          const SizedBox(height: 12),

          _SectionCard(
            title: 'Pääkanava',
            child: Text('${i.platform} • ${i.followers} seuraajaa'),
          ),
          const SizedBox(height: 12),

          const _SectionCard(
            title: 'Portfolio',
            child: Text('todo: kuvat/videot myöhemmin'),
          ),
          const SizedBox(height: 12),

          // todo: lisää myöhemmin samalla pohjalla:
          // - yleisö & statistiikka
          // - yhteistyöpreferenssit & paketit
        ],
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  const _HeaderCard({
    required this.name,
    required this.location,
    required this.primaryPlatform,
    required this.followers,
  });

  final String name;
  final String location;
  final String primaryPlatform;
  final int followers;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 26,
                child: Icon(Icons.person_outline),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 4),
                    Text(location, style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 8),
                    Text(
                      '$primaryPlatform • $followers seuraajaa',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: textTheme.titleMedium),
              const SizedBox(height: 10),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
