import 'package:flutter/material.dart';
import 'chat_thread_screen.dart';

/// ChatListScreen = keskustelulista.
///
/// MVP:
/// - kovakoodattu lista (ei backendia)
/// - avaa ChatThreadScreenin painamalla listaa
///
/// todo:
/// - hae keskustelut backendistä
/// - näytä unread-tila / viimeisin aika oikeasti / profiilikuva yritykselle
class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  // MVP: testidata suoraan tässä tiedostossa
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
    final cs = Theme.of(context).colorScheme;

    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: _mockChats.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, i) {
        final c = _mockChats[i];

        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: cs.secondary,
              child: const Icon(Icons.chat_bubble_outline),
            ),
            title: Text(c.name),
            subtitle: Text(
              c.lastMessage,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Text(c.time),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChatThreadScreen(chatTitle: c.name),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
