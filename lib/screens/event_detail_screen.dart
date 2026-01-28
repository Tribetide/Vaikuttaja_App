import 'package:flutter/material.dart';
import '../models/event.dart';

/// EventDetailScreen = tapahtuman tarkempi näkymä.
///
/// MVP:
/// - vaikuttaja: voi “Osallistua” -> palautetaan päivitetty EventItem (id lisätty listaan)
/// - yritys: pelkkä katselu (muokkaus hoidetaan listan kynästä)
class EventDetailScreen extends StatelessWidget {
  const EventDetailScreen({
    super.key,
    required this.event,
    required this.isCompanyView,
    required this.influencerId,
  });

  final EventItem event;
  final bool isCompanyView;

  /// MVP: kuka “osallistuu”
  final String influencerId;

  @override
  Widget build(BuildContext context) {
    final alreadyJoined = event.participantInfluencerIds.contains(influencerId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tapahtuma'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(event.title, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 6),

                Text(
                  event.companyName,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 14),

                Row(
                  children: [
                    const Icon(Icons.event_outlined, size: 18),
                    const SizedBox(width: 6),
                    Text(event.dateLabel, style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.place_outlined, size: 18),
                    const SizedBox(width: 6),
                    Text(event.location, style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),

                const SizedBox(height: 14),

                Text(event.shortDescription, style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 12),

                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: event.tags.map((t) => Chip(label: Text(t))).toList(),
                ),

                const Spacer(),

                if (!isCompanyView)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: alreadyJoined
                          ? null
                          : () {
                              // MVP: lisätään influencerId listaan ja palautetaan päivitetty event
                              final updated = EventItem(
                                id: event.id,
                                companyId: event.companyId,
                                companyName: event.companyName,
                                title: event.title,
                                dateLabel: event.dateLabel,
                                location: event.location,
                                shortDescription: event.shortDescription,
                                tags: event.tags,
                                isPublished: event.isPublished,
                                participantInfluencerIds: [
                                  ...event.participantInfluencerIds,
                                  influencerId,
                                ],
                              );

                              Navigator.pop(context, updated);

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Osallistuminen tallennettu (mvp)')),
                              );
                            },
                      icon: const Icon(Icons.how_to_reg_outlined),
                      label: Text(alreadyJoined ? 'Osallistut jo' : 'Osallistu'),
                    ),
                  )
                else
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: null,
                      icon: const Icon(Icons.info_outline),
                      label: const Text('Yritysnäkymä: muokkaus kynästä'),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
