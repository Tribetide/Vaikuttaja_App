import 'package:flutter/material.dart';

import '../models/influencer.dart';
import 'add_influencer_screen.dart';
import 'base_screen.dart';
import 'chat_list_screen.dart';
import 'events_list_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';

/// ShellScreen = sovelluksen “kuori” kirjautumisen jälkeen.
///
/// Vastuut:
/// - näyttää BaseScreenin (yläbanneri + sisällön sijoittelu)
/// - hallitsee BottomNavigationBarin (välilehtien vaihto)
/// - hoitaa MVP:ssä myös profiilidatan “väliaikaisen” tilan (ennen backendiä)
class ShellScreen extends StatefulWidget {
  const ShellScreen({super.key});

  @override
  State<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends State<ShellScreen> {
  int _index = 0;

  // MVP: pidetään influencer tässä, jotta AddInfluencerScreenin tallennus
  // voi päivittää profiilin ilman backendiä.
  //
  // todo: kun backend tulee, tämä siirtyy provider/repo -kerrokseen
  Influencer? _influencer;

  Future<void> _openEditInfluencer() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddInfluencerScreen()),
    );

    if (!mounted) return;

    if (result is Influencer) {
      setState(() => _influencer = result);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mediakortti tallennettu (mvp)')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Jokaisella tabilla voi olla omat header-actionit.
    final pages = <({String title, Widget child, List<Widget> actions})>[
      (title: 'Feed', child: const HomeScreen(), actions: const []),
      (title: 'Events', child: const EventsListScreen(), actions: const []),
      (title: 'Chat', child: const ChatListScreen(), actions: const []),
      (
        title: 'Oma mediakortti',
        child: ProfileScreen(influencer: _influencer),
        actions: [
          IconButton(
            tooltip: 'Muokkaa',
            icon: const Icon(Icons.edit_outlined),
            onPressed: _openEditInfluencer,
          ),
        ],
      ),
    ];

    final active = pages[_index];

    return Scaffold(
      body: SafeArea(
        child: BaseScreen(
          title: active.title,
          actions: active.actions,
          child: active.child,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Feed'),
          BottomNavigationBarItem(icon: Icon(Icons.event_outlined), label: 'Events'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profiili'),
        ],
      ),
    );
  }
}
