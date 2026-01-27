import 'package:flutter/material.dart';
import '../theme/app_theme_theme.dart';
import 'chat_thread_screen.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  // mvp: testidata suoraan tässä tiedostossa
  // todo: korvaa backendistä tulevalla keskustelulistalla
  static const _mockChats = [
    (
      name: 'Yritys Oy',
      lastMessage: 'Moikka! Kiinnostaisiko yhteistyö?',
      time: '12:40',
    ),
    (
      name: 'Somebrändi',
      lastMessage: 'Voidaanko sopia aikatauluista?',
      time: 'Eilen',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: _mockChats.length,
      separatorBuilder: (_, __) => Divider(
        height: 1,
        color: AppColors.primary.withAlpha((0.08 * 255).round()),
      ),
      itemBuilder: (context, i) {
        final c = _mockChats[i];

        return ListTile(
          leading: CircleAvatar(
            backgroundColor: AppColors.secondary.withAlpha((0.55 * 255).round()),
            child: Icon(Icons.chat_bubble_outline, color: AppColors.textPrimary),
          ),
          title: Text(
            c.name,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: AppColors.textPrimary),
          ),
          subtitle: Text(
            c.lastMessage,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppColors.textPrimary.withAlpha((0.75 * 255).round())),
          ),
          trailing: Text(
            c.time,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: AppColors.textPrimary.withAlpha((0.65 * 255).round())),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatThreadScreen(chatTitle: c.name),
              ),
            );
          },
        );
      },
    );
  }
}
