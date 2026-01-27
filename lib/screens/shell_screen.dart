import 'package:flutter/material.dart';
import '../theme/app_theme_theme.dart';
import 'base_screen.dart';
// import 'add_influencer_screen.dart';
import 'profile_screen.dart';
import 'home_screen.dart';
import 'chat_list_screen.dart';
import 'events_list_screen.dart';



// NOTE:
// ShellScreen = sovelluksen “kuori” / runkonäkymä kirjautumisen jälkeen.
// Se sisältää:
//  - yläosan (otsikko + mahdolliset toimintopainikkeet) BaseScreenin kautta
//  - bottom navigationin (Feed, Events, Chat, Profiili)
//  - itse välilehtien sisällöt (HomeScreen, ProfileScreen, placeholderit)
//
// Tavoite: kaikki pää-näkymät elävät ShellScreenin sisällä, jotta navigointi on selkeä
// ja yhtenäinen (sama header + sama bottom nav kaikkialla).

class ShellScreen extends StatefulWidget {
  const ShellScreen({super.key});

  @override
  State<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends State<ShellScreen> {
  // _index kertoo mikä välilehti (BottomNavigationBar) on aktiivinen.
  // 0 = Feed, 1 = Events, 2 = Chat, 3 = Profiili
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    // pages-lista on “yksi totuus” välilehtien sisällöistä ja otsikoista.
    // Tämän ansiosta:
    //  - BaseScreenin title vaihtuu automaattisesti
    //  - body vaihtuu automaattisesti
    //
    // Record-tyyppi: ({String title, Widget child})
    // -> selkeä ja kevyt tapa pitää title + child yhdessä.
    final pages = <({String title, Widget child})>[
      // Feed-välilehti: HomeScreen listaa vaikuttajat FeedCardeina
      (title: 'Feed', child: const HomeScreen()),

      // Events-välilehti: placeholder (rakennetaan myöhemmin).
      (title: 'Events', child: const EventsListScreen()),

      // Chat-välilehti: placeholder (rakennetaan myöhemmin).
      (title: 'Chat', child: const ChatListScreen()),

      // Profiili-välilehti: vaikuttajan oma profiili “muiden silmin”.
      // ProfileScreen näyttää korttipohjaisen mediakortin.
      (title: 'Oma mediakortti', child:const ProfileScreen()),
    ];

    return Scaffold(
      // AppColors tulee teemasta: pidetään brändivärit yhdessä paikassa.
      backgroundColor: AppColors.background,
      // SafeArea varmistaa, ettei sisältö mene loven / statusbarin alle.
      body: SafeArea(
        // BaseScreen on yhteinen wrapper:
        //  - piirtää yläbannerin (otsikko yms.)
        //  - sijoittaa childin oikeaan kohtaan
        //
        // Ajatus: ShellScreen ei itse rakenna headeria,
        // vaan delegoi sen BaseScreenille.
        child: BaseScreen(
          title: pages[_index].title,
          child: pages[_index].child,
        ),
      ),

      // BottomNavigationBar = pääasiallinen navigointi kirjautumisen jälkeen.
      // type: fixed -> 4 itemiä toimii hyvin, labelit aina näkyvissä.
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        // Kun käyttäjä painaa välilehteä:
        // -> päivitetään index ja Flutter rebuildaa BaseScreenin sisällön.
        onTap: (i) => setState(() => _index = i),
        type: BottomNavigationBarType.fixed,
        // Värit teemasta, jotta ilme pysyy yhtenäisenä.
        backgroundColor: AppColors.background,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.primary,
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
