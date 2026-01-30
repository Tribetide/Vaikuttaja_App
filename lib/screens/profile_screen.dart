import 'package:flutter/material.dart';
import '../models/influencer.dart';

// UUSI: tuo yhteiset widgetit
import '../widgets/app_header_card.dart';
import '../widgets/app_section_card.dart';

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
          // VANHA _HeaderCard -> UUSI AppHeaderCard
          AppHeaderCard(
            icon: Icons.person_outline,
            title: i.name,
            subtitle: location,
            meta: '${i.platform} • ${i.followers} seuraajaa',
          ),
          const SizedBox(height: 12),

          // VANHA _SectionCard -> UUSI AppSectionCard
          const AppSectionCard(
            title: 'Minä sisällöntuottajana',
            child: Text('Tekstiä minusta'),
          ),
          const SizedBox(height: 12),

          AppSectionCard(
            title: 'Pääkanava',
            child: Text('${i.platform} • ${i.followers} seuraajaa'),
          ),
          const SizedBox(height: 12),

          const AppSectionCard(
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
