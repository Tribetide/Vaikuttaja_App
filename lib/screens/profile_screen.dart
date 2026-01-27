import 'package:flutter/material.dart';

// ProfileScreen = vaikuttajan oma profiili “muiden silmin” (mediakortti).
//
// Tämän ruudun idea:
// - EI ole muokkauslomake.
// - Tämä on katselunäkymä: selkeä, korttipohjainen tarina vaikuttajasta.
// - Sisältö jaetaan pieniin ProfileCard-osioihin (helppo lukea + helppo laajentaa).
//
// Todo (seuraavat stepit, suositeltu järjestys):
// 1) Tee uudelleenkäytettävä widget: ProfileCard (widgets/profile_card.dart)
//    - otsikko + sisältö + yhtenäinen padding + reunat/varjo
// 2) Lisää perusinfo-kortti:
//    - profiilikuva, nimi, paikkakunta, slogan/tagline
// 3) Lisää “Minä sisällöntuottajana” -kortti:
//    - lyhyt kuvaus (tone, niche, arvot)
// 4) Lisää kanavakortit (Instagram/TikTok/...):
//    - seuraajat, engagement (myöhemmin), kohderyhmä
// 5) Lisää yhteistyöpreferenssit + paketit:
//    - mitä tekee / mitä ei tee, hinnat (myöhemmin), toimitusajat
// 6) Lisää portfolio-grid (kuvat/videot) placeholderina
// 7) Lisää “Muokkaa”-toiminto headeriin (BaseScreen actions):
//    - ohjaa EditInfluencerScreen/AddInfluencerScreen -lomakkeeseen
// 8) Kun Influencer-malli on käytössä:
//    - ProfileScreen ottaa Influencer-olion (tai hakee sen providerista)
//    - kaikki tekstit/datat tulevat yhdestä lähteestä (single source of truth)

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // SingleChildScrollView:
    // - profiili on usein pitkä (monta korttia)
    // - siksi scrollattava kokonaisuus on luonteva
    //
    // Todo:
    // Kun kortteja tulee paljon ja sisältö monimutkaistuu:
    // - harkitse CustomScrollView + SliverList/SliverToBoxAdapter
    //   (parempi suorituskyky + joustavammat “section headerit”)

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1) Profiiliheader (vain tämä pala)
          Row(
            children: [
              const CircleAvatar(
                radius: 40,
                child: Icon(Icons.person, size: 40),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Nimi / Nimimerkki', style: textTheme.titleLarge),
                    const SizedBox(height: 4),
                    Text('Seinäjoki', style: textTheme.bodyMedium),
                  ],
                ),
              ),
            ],
          ),
          // Todo (seuraava konkreettinen lisäys tänne alle):
          // Lisää SizedBox(height: 16) ja ensimmäinen ProfileCard:
          // - "Minä sisällöntuottajana"
          // - "Kanavat"
          // - "Yleisö & statistiikka"
          // - "Yhteistyöpaketit"
          // - "Portfolio"
        ],
      ),
    );
  }
}