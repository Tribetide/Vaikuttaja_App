import 'package:flutter/material.dart';
import 'event_detail_screen.dart';

/// EventsListScreen = Events-välilehden lista.
///
/// MVP:
/// - kovakoodattu tapahtumalista (ei backendia)
/// - Card + ListTile -tyylinen esitys, teema hoitaa ulkoasun
///
/// todo:
/// - korvaa mock-data backendin datalla
/// - lisää suodattimet (paikkakunta/tagit/aika)
class EventsListScreen extends StatelessWidget {
  const EventsListScreen({super.key});

  // MVP: testidata suoraan tässä tiedostossa
  // todo: korvaa backendistä tulevalla listalla
  static const _events = <EventItem>[
    EventItem(
      id: 'e1',
      title: 'Brändi-ilta & verkostoituminen',
      company: 'Yritys Oy',
      dateLabel: 'La 3.2. • 18:00',
      location: 'Helsinki',
      shortDescription: 'Tule tapaamaan tiimiä, tuotteita ja muita vaikuttajia.',
      tags: ['verkostoituminen', 'tuotelanseeraus'],
    ),
    EventItem(
      id: 'e2',
      title: 'Sisältöpäivä studiossa',
      company: 'Somebrändi',
      dateLabel: 'Ke 14.2. • 12:00',
      location: 'Tampere',
      shortDescription: 'Kuvauspisteet valmiina: tuota sisältöä paikan päällä.',
      tags: ['kuvaus', 'studio', 'UGC'],
    ),
    EventItem(
      id: 'e3',
      title: 'Pop-up tapahtuma',
      company: 'Kahvila & Co',
      dateLabel: 'Pe 1.3. • 16:00',
      location: 'Turku',
      shortDescription: 'Pop-up + maistatukset + yhteistyömahdollisuuksia.',
      tags: ['pop-up', 'maistatukset'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: _events.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, i) {
        final e = _events[i];

        return Card(
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EventDetailScreen(event: e),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(e.title, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(e.company, style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 10),

                  Row(
                    children: [
                      const Icon(Icons.event_outlined, size: 18),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          e.dateLabel,
                          style: Theme.of(context).textTheme.bodyMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(Icons.place_outlined, size: 18),
                      const SizedBox(width: 6),
                      Text(e.location, style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Text(e.shortDescription, style: Theme.of(context).textTheme.bodyMedium),

                  const SizedBox(height: 10),

                  // Tagit Chipillä -> chipTheme hoitaa ulkoasun
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: e.tags.map((t) => Chip(label: Text(t))).toList(),
                  ),

                  const SizedBox(height: 6),

                  // pieni “vihje” että kortti aukeaa
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text('Tutki'),
                      SizedBox(width: 4),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class EventItem {
  const EventItem({
    required this.id,
    required this.title,
    required this.company,
    required this.dateLabel,
    required this.location,
    required this.shortDescription,
    required this.tags,
  });

  final String id;
  final String title;
  final String company;
  final String dateLabel;
  final String location;
  final String shortDescription;
  final List<String> tags;

  // todo: lisää myöhemmin pidempi kuvaus, linkit, ilmoittautuminen, osallistujarajat jne.
}
