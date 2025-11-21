import 'package:flutter/material.dart';
import 'pages/home/home_page.dart';
import 'pages/calendar/calendar_page.dart';
import 'bondie/widget/animated_bondie_widget.dart';
import 'bondie/pages/bondie_page.dart';
import 'bondie/pages/stats/bondie_stats_controller.dart';
import 'pages/profiles/couple/couple_profile_page.dart';

void main() {
  runApp(const BondedApp());
}

class BondedApp extends StatelessWidget {
  const BondedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bonded',
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: const Color(0xFFF8F9FD),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3B82F6),
          secondary: const Color(0xFF06B6D4),
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MainScreen(),
    );
  }
}

// =====================================
// MAIN SCREEN (BOTTOM NAVIGATION)
// =====================================
class MainScreen extends StatefulWidget {
  final int initialIndex;
  const MainScreen({super.key, this.initialIndex = 0});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _selectedIndex;

  final BondieStatsController bondieStats = BondieStatsController();

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;

    _pages = [
      HomePage(bondieStats: bondieStats),
      const CalendarPage(),
      CoupleProfilePage(),   // ← abre aqui
      const Center(child: Text("Settings page coming soon")),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _pages[_selectedIndex],

          // Floating Bondie
          Positioned(
            right: 12,
            top: 60,
            child: GestureDetector(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        BondiePage(statsController: bondieStats),
                  ),
                );
                setState(() {});
              },
              child: AnimatedBondieWidget(controller: bondieStats),
            ),
          ),
        ],
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 10, bottom: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey.withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, -3),
            ),
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(26),
            topRight: Radius.circular(26),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: const Color(0xFF3B82F6),
          unselectedItemColor: Colors.grey[500],
          showUnselectedLabels: true,
          iconSize: 30,
          selectedFontSize: 14,
          unselectedFontSize: 13,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_rounded),
              label: 'Calendar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_rounded),
              label: 'Couple',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_rounded),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}

// Helper — open MainScreen at index
class MainScreenWithIndex extends StatelessWidget {
  final int index;
  const MainScreenWithIndex({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return MainScreen(initialIndex: index);
  }
}
