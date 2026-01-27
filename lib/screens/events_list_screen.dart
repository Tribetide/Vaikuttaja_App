import 'package:flutter/material.dart';
import '../theme/app_theme_theme.dart';
import 'event_detail_screen.dart';

class EventsListScreen extends StatelessWidget {
  const EventsListScreen({super.key});

  // mvp: kovakoodattu data tähän tiedostoon
  // todo: korvaa backendistä tulevalla datalla
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

  Color _alpha(Color c, double opacity) => c.withAlpha((opacity * 255).round());

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: _events.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, i) {
        final e = _events[i];

        return Material(
          elevation: 2,
          borderRadius: BorderRadius.circular(16),
          color: _alpha(AppColors.secondary, 0.28),
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
                  // otsikko + yritys
                  Text(
                    e.title,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: AppColors.textPrimary),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    e.company,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: _alpha(AppColors.textPrimary, 0.75),
                        ),
                  ),
                  const SizedBox(height: 10),

                  // aika + paikka
                  Row(
                    children: [
                      Icon(Icons.event_outlined, size: 18, color: AppColors.primary),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          e.dateLabel,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: AppColors.textPrimary),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Icon(Icons.place_outlined, size: 18, color: AppColors.primary),
                      const SizedBox(width: 6),
                      Text(
                        e.location,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: AppColors.textPrimary),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // lyhyt kuvaus
                  Text(
                    e.shortDescription,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: _alpha(AppColors.textPrimary, 0.90),
                        ),
                  ),

                  const SizedBox(height: 10),

                  // tagit
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: e.tags
                        .map((t) => _TagChip(text: t, alpha: _alpha))
                        .toList(),
                  ),

                  const SizedBox(height: 6),

                  // “tutki” -vihje
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Tutki',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.primary,
                            ),
                      ),
                      const SizedBox(width: 4),
                      Icon(Icons.chevron_right, color: AppColors.primary),
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

  // todo: lisää myöhemmin pidempi kuvaus, linkit, ilmoittautuminen, osallistujarajat, jne.
}

class _TagChip extends StatelessWidget {
  const _TagChip({required this.text, required this.alpha});

  final String text;
  final Color Function(Color, double) alpha;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: alpha(AppColors.surface, 0.85),
        border: Border.all(color: alpha(AppColors.primary, 0.10)),
      ),
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(color: AppColors.textPrimary),
      ),
    );
  }
}
