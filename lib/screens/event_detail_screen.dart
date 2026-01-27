import 'package:flutter/material.dart';
import 'events_list_screen.dart';

/// EventDetailScreen = yksittäisen tapahtuman tarkempi näkymä.
///
/// MVP:
/// - näyttää perustiedot (otsikko, yritys, aika, paikka, kuvaus)
/// - “Ota yhteyttä” -nappi placeholderina
///
/// todo:
/// - lisää pidempi kuvaus, mahdolliset linkit ja ilmoittautuminen
/// - “Ota yhteyttä” -> avaa chat yritykseen (kun yritys/roolit kytketään)
class EventDetailScreen extends StatelessWidget {
  const EventDetailScreen({super.key, required this.event});

  final EventItem event;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar ja tausta tulevat teemasta (AppBarTheme + scaffoldBackgroundColor)
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
                Text(event.company, style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 14),

                Row(
                  children: [
                    const Icon(Icons.event_outlined, size: 18),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(event.dateLabel, style: Theme.of(context).textTheme.bodyMedium),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.place_outlined, size: 18),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(event.location, style: Theme.of(context).textTheme.bodyMedium),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                Text(event.shortDescription, style: Theme.of(context).textTheme.bodyMedium),

                const Spacer(),

                // MVP: placeholder-toiminto
                // todo: backendissä -> avaa chat / ilmoittaudu / ota yhteyttä
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('mvp: toiminto lisätään myöhemmin')),
                      );
                    },
                    icon: const Icon(Icons.chat_bubble_outline),
                    label: const Text('Ota yhteyttä'),
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
