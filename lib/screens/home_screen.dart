import 'package:flutter/material.dart';

import '../models/company.dart';
import '../models/influencer.dart';

/// HomeScreen = Feed-välilehti (MVP).
///
/// Sama näkymä molemmille rooleille, mutta sisältö vaihtuu:
/// - Yritys (isCompanyView = true): selaa vaikuttajia
/// - Vaikuttaja (isCompanyView = false): selaa yrityksiä
///
/// todo:
/// - korvaa ListTile -> oikea FeedCard / CompanyCard myöhemmin
/// - lisää haku/suodatus myöhemmin
/// - kytke backend (repository/provider)
class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.isCompanyView,
  });

  final bool isCompanyView;

  // ------------------------------------------------------------
  // MVP mock-data (suoraan tässä tiedostossa)
  // ------------------------------------------------------------

  List<Influencer> get _mockInfluencers => [
        Influencer(
          id: 'i1',
          name: 'Mimosa',
          platform: 'Instagram',
          followers: 58000,
          price: 0,
          imageUrl: '',
        ),
        Influencer(
          id: 'i2',
          name: 'Test Influencer',
          platform: 'TikTok',
          followers: 120000,
          price: 0,
          imageUrl: '',
        ),
      ];

  List<Company> get _mockCompanies => [
        Company(
          id: 'c1',
          name: 'Yritys Oy',
          industry: 'Beauty / Lifestyle',
          location: 'Helsinki',
          description: 'Brändi-iltoja, kampanjoita ja sisältöpäiviä.',
          logoUrl: '',
          contactName: 'Yhteyshenkilö',
          contactEmail: 'info@yritys.fi',
        ),
        Company(
          id: 'c2',
          name: 'Somebrändi',
          industry: 'Tech / Apps',
          location: 'Tampere',
          description: 'Etsimme sisällöntuottajia tuote-esittelyihin.',
          logoUrl: '',
          contactName: 'Yhteyshenkilö',
          contactEmail: 'hello@somebrandi.fi',
        ),
      ];

  @override
  Widget build(BuildContext context) {
    // Valitaan listan data roolin mukaan
    final items = isCompanyView ? _mockInfluencers : _mockCompanies;

    return ListView.separated(
      padding: EdgeInsets.zero, // BaseScreen hoitaa paddingin
      itemCount: items.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        if (isCompanyView) {
          final influencer = items[index] as Influencer;

          return Card(
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person_outline)),
              title: Text(influencer.name),
              subtitle: Text('${influencer.platform} • ${influencer.followers} seuraajaa'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // todo: avaa vaikuttajan profiili yritykselle
                // (myöhemmin esim. InfluencerDetailScreen)
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('todo: avaa vaikuttajan profiili')),
                );
              },
            ),
          );
        } else {
          final company = items[index] as Company;

          return Card(
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.apartment_outlined)),
              title: Text(company.name),
              subtitle: Text('${company.industry} • ${company.location}'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // todo: avaa yrityksen profiili vaikuttajalle
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('todo: avaa yrityksen profiili')),
                );
              },
            ),
          );
        }
      },
    );
  }
}
