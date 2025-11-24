import 'package:flutter/material.dart';
import '../../main.dart';
import 'stats/bondie_stats.dart';
import 'stats/bondie_stats_controller.dart';
import 'actions/bondie_actions.dart';
import 'package:bondedapp/layout/app_background.dart';

class BondiePage extends StatefulWidget {
  final BondieStatsController statsController;

  const BondiePage({
    super.key,
    required this.statsController,
  });

  @override
  State<BondiePage> createState() => _BondiePageState();
}

class _BondiePageState extends State<BondiePage>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: -6, end: 6).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),

      bottomNavigationBar: _buildBottomNavBar(),

      body: AppBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Bondie",
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      height: 1.1,
                    ),
                  ),
                ),

                const SizedBox(height: 0),

                BondieStats(
                  floatAnimation: _floatAnimation,
                  controller: widget.statsController,
                ),

                const SizedBox(height: 13),

                BondieActions(controller: widget.statsController),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Bottom navigation bar
  Widget _buildBottomNavBar() {
    return Container(
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
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: Colors.grey[500],
        unselectedItemColor: Colors.grey[500],
        iconSize: 30,
        selectedFontSize: 13,
        unselectedFontSize: 13,
        onTap: (index) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => MainScreenWithIndex(index: index),
            ),
                (_) => false,
          );
        },
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
    );
  }
}
