import 'package:flutter/material.dart';
import '../models/influencer.dart';

// HomeScreen = Feed-välilehden sisältö.
//
// Tämän ruudun tarkoitus:
// - Listata yritykselle selattavaksi vaikuttajia kevyinä nostoina (FeedCard).
// - MVP-vaiheessa käytetään mock-dataa, jotta UI voidaan rakentaa ilman backendiä.
// - Myöhemmin tämä ruutu hakee datan esim. providerin / BLoCin / repositoryn kautta.
//
// NOTE:
// Nyt käytössä on ListTile, koska se on nopea “placeholder”.
// Seuraava askel: korvaa ListTile -> FeedCard widgetillä, joka näyttää:
// - bannerikuva / video
// - profiilikuva
// - nimi + perusinfo
// - 2–3 nostokohtaa
// - CTA-painike “Siirry profiiliin”

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Mock-data MVP:tä varten
  // Kun backend tulee mukaan: korvaa tämä esim. InfluencerRepositoryn datalla.
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
    // ListView.builder:
    // - tehokas isoille listoille (rakentaa rivit “lazy”)
    // - toimii hyvin feediin, jossa kortteja voi olla paljon
    return ListView.builder(
      // NOTE:
      // BaseScreenissä on jo padding: const EdgeInsets.all(16)
      // mutta tässä on myös padding(16). Tämä voi johtaa “tuplapaddingiin”.
      //
      // Todo:
      // Päätä yksi “totuuden lähde” paddingille:
      // - Joko poistetaan tämä padding kokonaan ja luotetaan BaseScreeniin
      // - TAI BaseScreenin padding tehdään joustavaksi (parametri) ja hallitaan täällä
      padding: const EdgeInsets.all(16),
      itemCount: mockInfluencers.length,
      itemBuilder: (context, index) {
        // Haetaan listasta yksi vaikuttaja.
        final influencer = mockInfluencers[index];

        // Jokainen listan “rivi” / kortti.
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),

          // ListTile toimii placeholderina.
          //
          // Todo:
          // Korvaa myöhemmin FeedCard(influencer: influencer),
          // ja lisää onTap -> siirtyminen profiiliin (ProfileScreen tai InfluencerDetailScreen).
          child: ListTile(
            tileColor: Colors.white,
            title: Text(influencer.name),

            // Perusinfo (kanava + seuraajamäärä).
            // Todo: formaatointi:
            // - seuraajat voisi näyttää lyhyemmin: 58k, 120k jne.
            // - lisää myöhemmin esim. niche / tyyli / 2–3 bullet pointtia FeedCardiin
            subtitle: Text(
              '${influencer.platform} • ${influencer.followers} seuraajaa',
            ),
          ),
        );
      },
    );
  }
}
