import 'package:flutter/material.dart';
import '../theme/app_theme_theme.dart';
import 'base_screen.dart';
// import 'add_influencer_screen.dart';
import 'profile_screen.dart';
import 'home_screen.dart';



class ShellScreen extends StatefulWidget {
  const ShellScreen({super.key});

  @override
  State<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends State<ShellScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = <({String title, Widget child})>[
      (title: 'Feed', child: const HomeScreen()),
      (title: 'Events', child: const Center(child: Text('Events content'))),
      (title: 'Chat', child: const Center(child: Text('Chat content'))),
      (title: 'Oma mediakortti', child:const ProfileScreen()),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: BaseScreen(
          title: pages[_index].title,
          child: pages[_index].child,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        type: BottomNavigationBarType.fixed,
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
