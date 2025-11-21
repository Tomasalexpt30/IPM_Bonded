import 'package:flutter/material.dart';
import 'package:bondedapp/layout/app_background.dart';
import '../../../bondie/pages/stats/bondie_stats_controller.dart';

import 'widgets/couple_section.dart';
import 'widgets/daily_activity.dart';
import 'widgets/time_capsule.dart';
import 'widgets/weekly_challenge.dart';

class HomePage extends StatelessWidget {
  final BondieStatsController bondieStats;

  const HomePage({
    super.key,
    required this.bondieStats,
  });

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

                  // Title
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

                  // Couple section
                  CoupleSection(controller: bondieStats),
                  const SizedBox(height: 35),

                  // Daily activity
                  const DailyActivityCard(),
                  const SizedBox(height: 35),

                  // Time Capsule
                  const TimeCapsuleCard(),
                  const SizedBox(height: 35),

                  // Weekly Challenge
                  const WeeklyChallengeCard(),
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
