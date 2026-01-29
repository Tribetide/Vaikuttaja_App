import 'package:flutter/material.dart';

import '../models/event.dart';
import 'create_or_edit_event_screen.dart';
import 'event_detail_screen.dart';

/// EventsListScreen = Events-välilehden sisältö (MVP).
///
/// Sama layout molemmille rooleille, mutta eri logiikka:
/// - Yritys:
///   - näkee omat tapahtumat (draft + published)
///   - “Luo uusi tapahtuma” nappi listan yläpuolella
///   - kynä-ikonista muokataan
/// - Vaikuttaja:
///   - näkee vain published-tapahtumat
///   - voi avata detailin ja “Osallistua”
///
/// todo (backend):
/// - eventit tulevat backendistä (queryt roolin mukaan)
/// - osallistuminen tallennetaan backendille
class EventsListScreen extends StatefulWidget {
  const EventsListScreen({
    super.key,
    required this.isCompanyView,
  });

  /// true = yritysnäkymä, false = vaikuttajanäkymä
  final bool isCompanyView;

  @override
  State<EventsListScreen> createState() => _EventsListScreenState();
}

class _EventsListScreenState extends State<EventsListScreen> {
  // MVP: demotunnisteet (myöhemmin auth/backendistä)
  static const String _demoCompanyId = 'company-1';
  static const String _demoCompanyName = 'Yritys Oy';
  static const String _demoInfluencerId = 'influencer-1';

  // MVP: pidetään “koko event-kanta” muistissa tässä screenissä
  // (myöhemmin tulee repository/provider)
  late final List<EventItem> _events = [
    EventItem(
      id: 'e1',
      companyId: _demoCompanyId,
      companyName: _demoCompanyName,
      title: 'Brändi-ilta & verkostoituminen',
      dateLabel: 'La 3.2. • 18:00',
      location: 'Helsinki',
      shortDescription: 'Tule tapaamaan tiimiä, tuotteita ja muita vaikuttajia.',
      tags: const ['verkostoituminen', 'tuotelanseeraus'],
      isPublished: true,
      participantInfluencerIds: const [],
    ),
    EventItem(
      id: 'e2',
      companyId: _demoCompanyId,
      companyName: _demoCompanyName,
      title: 'Sisältöpäivä studiossa',
      dateLabel: 'Ke 14.2. • 12:00',
      location: 'Tampere',
      shortDescription: 'Kuvauspisteet valmiina: tuota sisältöä paikan päällä.',
      tags: const ['kuvaus', 'studio', 'UGC'],
      isPublished: false, // draft -> näkyy vain yritykselle
      participantInfluencerIds: const [],
    ),
  ];

  List<EventItem> get _visibleEvents {
    if (widget.isCompanyView) {
      // Yritys näkee omat (draft + published)
      return _events.where((e) => e.companyId == _demoCompanyId).toList();
    }
    // Vaikuttaja näkee vain published (kaikilta yrityksiltä)
    return _events.where((e) => e.isPublished).toList();
  }

  Future<void> _createNewEvent() async {
    final created = await Navigator.push<EventItem>(
      context,
      MaterialPageRoute(
        builder: (_) => CreateOrEditEventScreen(
          // Uusi tapahtuma: initial = null
          initial: null,
          // MVP: yrityksen tiedot syötetään valmiiksi
          companyId: _demoCompanyId,
          companyName: _demoCompanyName,
        ),
      ),
    );

    if (created == null) return;

    setState(() {
      _events.add(created);
    });
  }

  Future<void> _editEvent(EventItem event) async {
    final updated = await Navigator.push<EventItem>(
      context,
      MaterialPageRoute(
        builder: (_) => CreateOrEditEventScreen(
          initial: event,
          companyId: _demoCompanyId,
          companyName: _demoCompanyName,
        ),
      ),
    );

    if (updated == null) return;

    setState(() {
      final idx = _events.indexWhere((e) => e.id == updated.id);
      if (idx != -1) _events[idx] = updated;
    });
  }

  Future<void> _openDetail(EventItem event) async {
    final updated = await Navigator.push<EventItem>(
      context,
      MaterialPageRoute(
        builder: (_) => EventDetailScreen(
          event: event,
          isCompanyView: widget.isCompanyView,
          // MVP: vaikuttajan id osallistumista varten
          influencerId: _demoInfluencerId,
        ),
      ),
    );

    // Influencer-detail voi palauttaa “päivitetyn eventin” (osallistuja lisätty)
    if (updated == null) return;

    setState(() {
      final idx = _events.indexWhere((e) => e.id == updated.id);
      if (idx != -1) _events[idx] = updated;
    });
  }

  @override
  Widget build(BuildContext context) {
    final events = _visibleEvents;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.isCompanyView) ...[
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _createNewEvent,
              icon: const Icon(Icons.add),
              label: const Text('Luo uusi tapahtuma'),
            ),
          ),
          const SizedBox(height: 12),
        ],

        if (events.isEmpty)
          _EmptyState(
            isCompanyView: widget.isCompanyView,
            onCreate: widget.isCompanyView ? _createNewEvent : null,
          )
        else
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero, // BaseScreen hoitaa paddingin
              itemCount: events.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, i) {
                final e = events[i];

                return Card(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () => _openDetail(e),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Otsikko + oikealle edit-kynä vain yritykselle
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  e.title,
                                  style: Theme.of(context).textTheme.titleMedium,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (widget.isCompanyView)
                                IconButton(
                                  tooltip: 'Muokkaa',
                                  onPressed: () => _editEvent(e),
                                  icon: const Icon(Icons.edit_outlined),
                                ),
                            ],
                          ),
                          const SizedBox(height: 4),

                          // Yrityksen nimi näkyy vaikuttajalle hyödyllisenä
                          if (!widget.isCompanyView) ...[
                            Text(
                              e.companyName,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(height: 10),
                          ] else
                            const SizedBox(height: 10),

                          // Aika + paikka
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
                              Text(
                                e.location,
                                style: Theme.of(context).textTheme.bodyMedium,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),

                          // Kuvaus
                          Text(
                            e.shortDescription,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),

                          const SizedBox(height: 10),

                          // Tagit
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: e.tags.map((t) => Chip(label: Text(t))).toList(),
                          ),

                          // Yritykselle pieni “tilainfo” (vain MVP-demoon)
                          if (widget.isCompanyView) ...[
                            const SizedBox(height: 10),
                            Text(
                              e.isPublished ? 'Julkaistu' : 'Luonnos',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({
    required this.isCompanyView,
    this.onCreate,
  });

  final bool isCompanyView;
  final VoidCallback? onCreate;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isCompanyView ? 'Ei vielä tapahtumia' : 'Ei julkaistuja tapahtumia',
              style: textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              isCompanyView
                  ? 'Luo ensimmäinen tapahtuma, jotta vaikuttajat voivat nähdä sen Events-välilehdessä.'
                  : 'Tarkista myöhemmin uudestaan — yritykset julkaisevat tapahtumia tänne.',
              style: textTheme.bodyMedium,
            ),
            if (isCompanyView) ...[
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onCreate,
                  icon: const Icon(Icons.add),
                  label: const Text('Luo uusi tapahtuma'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
