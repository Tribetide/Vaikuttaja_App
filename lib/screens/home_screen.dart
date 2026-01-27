import 'package:flutter/material.dart';
import '../models/influencer.dart';

/// HomeScreen = Feed-välilehden sisältö.
///
/// MVP:
/// - listaa vaikuttajia kovakoodatulla datalla (ei backendia)
/// - käyttää ListTileä placeholderina
///
/// todo:
/// - korvaa ListTile -> FeedCard (banner, avatar, nostot, CTA)
/// - lisää onTap -> avaa vaikuttajan profiili / detail
/// - tuo data myöhemmin repositorystä / backendistä
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // MVP: mock-data tässä tiedostossa.
  // todo: korvaa myöhemmin datalähteellä (repository / backend)
  List<Influencer> get _mockInfluencers => [
    Influencer(
      id: '1',
      name: 'Mimosa',
      platform: 'Instagram',
      followers: 58000,
      price: 0,
      imageUrl: '',
    ),
    Influencer(
      id: '2',
      name: 'Test Influencer',
      platform: 'TikTok',
      followers: 120000,
      price: 0,
      imageUrl: '',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      // BaseScreen hoitaa peruspaddingin -> ei tuplapaddingia
      padding: EdgeInsets.zero,
      itemCount: _mockInfluencers.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final influencer = _mockInfluencers[index];

        return Card(
          // CardTheme hoitaa ulkoasun (varjo/pinta/reunat)
          child: ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person_outline)),
            title: Text(influencer.name),
            subtitle: Text('${influencer.platform} • ${influencer.followers} seuraajaa'),
            onTap: () {
              // todo: avaa vaikuttajan profiili / detail
              // Navigator.push(...);
            },
          ),
        );
      },
    );
  }
}
