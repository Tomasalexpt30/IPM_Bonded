import 'package:flutter/material.dart';

import 'pages/splash_screen/splash_screen.dart';
import 'pages/home/home_page.dart';
import 'pages/calendar/calendar_page.dart';
import 'pages/profiles/couple/couple_profile_page.dart';
import 'pages/settings/settings_page.dart';

import 'bondie/widget/animated_bondie_widget.dart';
import 'bondie/pages/bondie_page.dart';
import 'bondie/pages/stats/bondie_stats_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const BondedApp());
}

class BondedApp extends StatelessWidget {
  const BondedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bonded',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8F9FD),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB),
          secondary: const Color(0xFF06B6D4),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  final int initialIndex;
  const MainScreen({super.key, this.initialIndex = 0});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final BondieStatsController bondieStats = BondieStatsController();

  int _selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    _selectedIndex = widget.initialIndex;

    _pages = [
      HomePage(bondieStats: bondieStats),
      const CalendarPage(),
      CoupleProfilePage(controller: bondieStats),
      const SettingsPage(),
    ];
  }

  void _onTabTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _pages[_selectedIndex],

          Positioned(
            right: 12,
            top: 60,
            child: GestureDetector(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BondiePage(statsController: bondieStats),
                  ),
                );
                setState(() {});
              },
              child: AnimatedBondieWidget(controller: bondieStats),
            ),
          ),
        ],
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 10, bottom: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(26),
            topRight: Radius.circular(26),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey.withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onTabTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconSize: 30,
          selectedFontSize: 14,
          unselectedFontSize: 13,
          selectedItemColor: const Color(0xFF2563EB),
          unselectedItemColor: Colors.grey[500],
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

class MainScreenWithIndex extends StatelessWidget {
  final int index;
  const MainScreenWithIndex({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return MainScreen(initialIndex: index);
  }
}
