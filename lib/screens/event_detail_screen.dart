import 'package:flutter/material.dart';
import '../theme/app_theme_theme.dart';
import 'events_list_screen.dart';

class EventDetailScreen extends StatelessWidget {
  const EventDetailScreen({super.key, required this.event});

  final EventItem event;

  Color _alpha(Color c, double opacity) => c.withAlpha((opacity * 255).round());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Tapahtuma'),
        backgroundColor: AppColors.secondary,
        foregroundColor: AppColors.textPrimary,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Material(
          elevation: 2,
          borderRadius: BorderRadius.circular(16),
          color: _alpha(AppColors.secondary, 0.28),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: AppColors.textPrimary),
                ),
                const SizedBox(height: 6),
                Text(
                  event.company,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: _alpha(AppColors.textPrimary, 0.75),
                      ),
                ),
                const SizedBox(height: 14),

                Row(
                  children: [
                    Icon(Icons.event_outlined, size: 18, color: AppColors.primary),
                    const SizedBox(width: 6),
                    Text(
                      event.dateLabel,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: AppColors.textPrimary),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.place_outlined, size: 18, color: AppColors.primary),
                    const SizedBox(width: 6),
                    Text(
                      event.location,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: AppColors.textPrimary),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                Text(
                  event.shortDescription,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: _alpha(AppColors.textPrimary, 0.90),
                      ),
                ),

                const Spacer(),

                // mvp: nappi placeholderina
                // todo: backendissä tämä voisi olla “Ilmoittaudu” / “Ota yhteyttä” / “Avaa chat yritykseen”
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
