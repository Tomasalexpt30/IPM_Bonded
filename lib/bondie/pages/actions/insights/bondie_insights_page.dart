import 'dart:math';
import 'package:flutter/material.dart';
import '../../../../main.dart';
import 'package:bondedapp/layout/app_background.dart';

// IMPORTS DAS OPÇÕES
import 'options/tip_of_the_day.dart';
import 'options/affection_boost.dart';
import 'options/energy_reset.dart';
import 'options/couple_exercise.dart';
import 'options/ask_bondie.dart';

class BondieInsightsPage extends StatefulWidget {
  const BondieInsightsPage({super.key});

  @override
  State<BondieInsightsPage> createState() => _BondieInsightsPageState();
}

class _BondieInsightsPageState extends State<BondieInsightsPage> {
  late String _currentInsight;
  final _random = Random();

  final List<String> _mainInsights = const [
    "Did you know small everyday gestures can strengthen any relationship?",
    "I woke up extra inspired today! I’ve got a special idea for you two.",
    "Connection isn’t only in the big moments – it lives in the tiny details of your day.",
    "Communication is the bridge between you both – talk a little more today 💙",
    "Even on hard days, remembering you’re a team changes everything.",
    "Love grows when you care for each other in simple, intentional ways.",
    "Little surprises create big memories. Maybe today is a good day for one.",
    "I’ve got a mini mission for you below 👇",
  ];

  @override
  void initState() {
    super.initState();
    _currentInsight = _randomInsight();
  }

  String _randomInsight() {
    return _mainInsights[_random.nextInt(_mainInsights.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      bottomNavigationBar: _buildBottomBar(context),

      body: AppBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  const SizedBox(height: 6),
                  _buildHeader(),

                  const SizedBox(height: 20),
                  _buildBondieInsight(),

                  const SizedBox(height: 18),

                  _buildInsightCard(
                    icon: Icons.lightbulb_outline_rounded,
                    title: "Tip of the Day",
                    description: "A simple idea from Bondie to try today.",
                    color: const Color(0xFF7AB6F6),
                    onTap: () => TipOfTheDayOption.show(context),
                  ),

                  const SizedBox(height: 18),

                  _buildInsightCard(
                    icon: Icons.favorite_rounded,
                    title: "Affection Boost",
                    description:
                    "Small actions that increase warmth and closeness.",
                    color: const Color(0xFFF69AB4),
                    onTap: () => AffectionBoostOption.show(context),
                  ),

                  const SizedBox(height: 18),

                  _buildInsightCard(
                    icon: Icons.bolt_rounded,
                    title: "Energy Reset",
                    description:
                    "Quick suggestions to reset the mood when the day feels heavy.",
                    color: const Color(0xFFFFB834),
                    onTap: () => EnergyResetOption.show(context),
                  ),

                  const SizedBox(height: 18),

                  _buildInsightCard(
                    icon: Icons.handshake_rounded,
                    title: "Quick Couple Exercise",
                    description:
                    "Short, simple exercises to strengthen your bond.",
                    color: const Color(0xFF8C4AD3),
                    onTap: () => CoupleExerciseOption.show(context),
                  ),

                  const SizedBox(height: 18),

                  _buildInsightCard(
                    icon: Icons.chat_bubble_outline_rounded,
                    title: "Ask Bondie Anything",
                    description:
                    "Tap to get a special response from Bondie.",
                    color: const Color(0xFF5EC8A7),
                    onTap: () => AskBondieOption.show(context),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      height: 40,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Padding(
                padding: EdgeInsets.only(left: 4),
                child: Icon(
                  Icons.arrow_back_rounded,
                  size: 26,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          const Text(
            "Bondie Insights",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBondieInsight() {
    final bubbleColor = const Color(0xFFD8EAFE);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Image.asset(
              "assets/images/bondie_icons/bondie_talking.png",
              height: 90,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              decoration: BoxDecoration(
                color: bubbleColor,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: const Color(0xFFAAC7F8),
                  width: 1.6,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueGrey.withOpacity(0.20),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _currentInsight,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: () {
                        setState(() {
                          _currentInsight = _randomInsight();
                        });
                      },
                      icon: const Icon(Icons.refresh_rounded, size: 18),
                      label: const Text(
                        "New insight",
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey.withOpacity(0.10),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, size: 28, color: color),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 13.5,
                      color: Colors.black54,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded,
                size: 18, color: Colors.black38),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(26), topRight: Radius.circular(26)),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: Colors.grey[600],
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
