import 'package:flutter/material.dart';

import 'base_screen.dart';
import 'chat_list_screen.dart';
import 'events_list_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'company_profile_screen.dart';

/// MVP: demoa varten voidaan vaihtaa roolia headeristä.
/// todo: poistetaan myöhemmin kun oikea auth/rooli on käytössä.
enum UserRole { influencer, company }

/// ShellScreen = sovelluksen “kuori” kirjautumisen jälkeen.
///
/// Vastuut:
/// - näyttää BaseScreenin (yläbanneri + sisällön sijoittelu)
/// - hallitsee BottomNavigationBarin (välilehtien vaihto)
/// - MVP:ssä myös demottaa roolinvaihtoa (vaikuttaja/yritys)
class ShellScreen extends StatefulWidget {
  const ShellScreen({super.key});

  @override
  State<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends State<ShellScreen> {
  // Aktiivinen välilehti: 0 = Feed, 1 = Events, 2 = Chat, 3 = Profiili
  int _index = 0;

  // MVP: demotila (vaihda roolia headeristä)
  UserRole _role = UserRole.influencer;

  void _toggleRole() {
    setState(() {
      _role = _role == UserRole.influencer ? UserRole.company : UserRole.influencer;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _role == UserRole.influencer
              ? 'Demo: Vaikuttaja-näkymä'
              : 'Demo: Yritys-näkymä',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Profiilin sisältö vaihtuu roolin mukaan
    final profileChild =
        _role == UserRole.influencer ? const ProfileScreen() : const CompanyProfileScreen();

    // Headerissä aina näkyvä demovaihtaja
    final headerActions = <Widget>[
      IconButton(
        tooltip: _role == UserRole.influencer ? 'Vaihda yritykseen' : 'Vaihda vaikuttajaan',
        icon: Icon(
          _role == UserRole.influencer
              ? Icons.apartment_outlined
              : Icons.person_outline,
        ),
        onPressed: _toggleRole,
      ),
    ];

    // “Yksi totuus” välilehdistä: title + child
    final pages = <({String title, Widget child})>[
      (title: 'Feed', child: HomeScreen(isCompanyView: _role == UserRole.company)),
      (title: 'Events', child: EventsListScreen(isCompanyView: _role == UserRole.company)),
      (title: 'Chat', child: ChatListScreen(isCompanyView: _role == UserRole.company)),
      (title: 'Profiili', child: profileChild),
    ];

    final active = pages[_index];

    return Scaffold(
      body: SafeArea(
        child: BaseScreen(
          title: active.title,
          actions: headerActions,
          child: active.child,
        ),
      ),

      // BottomNavigationBar käyttää ThemeData.bottomNavigationBarTheme -määrittelyjä
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
