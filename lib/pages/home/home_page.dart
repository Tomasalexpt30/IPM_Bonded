import 'package:bondedapp/pages/home/widgets/daily_question.dart';
import 'package:bondedapp/pages/time_capsule/closed/time_capsule_closed_page.dart';
import 'package:flutter/material.dart';
import 'package:bondedapp/layout/app_background.dart';
import '../../../bondie/pages/stats/bondie_stats_controller.dart';

import 'widgets/couple_section.dart';
import 'widgets/daily_game.dart';
import 'widgets/time_capsule.dart';

// IMPORTA A PÁGINA NOVA
import 'package:bondedapp/pages/time_capsule/submission/time_capsule_submission_page.dart';

class HomePage extends StatelessWidget {
  final BondieStatsController bondieStats;

  const HomePage({
    super.key,
    required this.bondieStats,
  });

  // ---------- MINI TITLE (igual à SettingsPage) ----------
  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Colors.black87,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),

      body: AppBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // ---------------------------------------------------
                  // HEADER
                  // ---------------------------------------------------
                  const Padding(
                    padding: EdgeInsets.only(bottom: 30),
                    child: Text(
                      "Home",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),

                  // ---------------------------------------------------
                  // MEMORY OF THE DAY
                  // ---------------------------------------------------
                  CoupleSection(controller: bondieStats),
                  const SizedBox(height: 35),

                  // ---------------------------------------------------
                  // DAILY ACTIVITIES TITLE
                  // ---------------------------------------------------
                  _sectionTitle("Daily Activities"),
                  const SizedBox(height: 16),

                  // DAILY GAME
                  DailyGameCard(controller: bondieStats),
                  const SizedBox(height: 20),

                  // DAILY QUESTION
                  const DailyQuestionCard(),
                  const SizedBox(height: 35),

                  // ---------------------------------------------------
                  // TIME CAPSULE TITLE
                  // ---------------------------------------------------
                  _sectionTitle("Time Capsule"),
                  const SizedBox(height: 16),

                  // Time Capsule (CLICKABLE)
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TimeCapsuleClosedPage(
                            controller: bondieStats,
                          ),
                        ),
                      );
                    },
                    child: const TimeCapsuleCard(),
                  ),
                  const SizedBox(height: 35),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
