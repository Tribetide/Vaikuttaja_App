import 'package:flutter/material.dart';
import 'chat_thread_screen.dart';

/// ChatListScreen = keskustelulista (sama layout molemmille rooleille).
///
/// MVP-roolilogiikka:
/// - jos isCompanyView == true: näytetään vaikuttaja-keskustelut (yritys keskustelee vaikuttajien kanssa)
/// - jos isCompanyView == false: näytetään yritys-keskustelut (vaikuttaja keskustelee yritysten kanssa)
///
/// todo (backend):
/// - korvaa mock-data keskustelulistalla (viimeisin viesti, unread, threadId...)
class ChatListScreen extends StatelessWidget {
  const ChatListScreen({
    super.key,
    required this.isCompanyView,
  });

  /// true = yritysnäkymä, false = vaikuttajanäkymä
  final bool isCompanyView;

  // MVP: mock-keskustelut yritykselle (eli yritys keskustelee vaikuttajien kanssa)
  static const _companyChats = [
    (
      name: 'Mimosa',
      lastMessage: 'Moikka! Kiinnostaisiko yhteistyö?',
      time: '12:40',
    ),
    (
      name: 'Test Influencer',
      lastMessage: 'Voisin tehdä UGC-videon tästä tuotteesta.',
      time: 'Eilen',
    ),
  ];

  // MVP: mock-keskustelut vaikuttajalle (eli vaikuttaja keskustelee yritysten kanssa)
  static const _influencerChats = [
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
    final chats = isCompanyView ? _companyChats : _influencerChats;
    final dividerColor = Theme.of(context).dividerTheme.color;

    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: chats.length,
      separatorBuilder: (context, index) => Divider(
        height: 1,
        color: dividerColor,
      ),
      itemBuilder: (context, i) {
        final c = chats[i];

        return ListTile(
          leading: CircleAvatar(
            child: Icon(
              isCompanyView ? Icons.person_outline : Icons.apartment_outlined,
            ),
          ),
          title: Text(
            c.name,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          subtitle: Text(
            c.lastMessage,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          trailing: Text(
            c.time,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChatThreadScreen(chatTitle: c.name),
              ),
            );
          },
        );
      },
    );
  }
}
