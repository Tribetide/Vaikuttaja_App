import 'package:flutter/material.dart';
import '../models/influencer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Mock-data MVP:tä varten
  List<Influencer> get mockInfluencers => [
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
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: mockInfluencers.length,
      itemBuilder: (context, index) {
        final influencer = mockInfluencers[index];

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            tileColor: Colors.white,
            title: Text(influencer.name),
            subtitle: Text(
              '${influencer.platform} • ${influencer.followers} seuraajaa',
            ),
          ),
        );
      },
    );
  }
}
