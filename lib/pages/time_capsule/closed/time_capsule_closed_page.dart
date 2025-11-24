import 'package:flutter/material.dart';
import 'package:bondedapp/layout/app_background.dart';
import 'package:bondedapp/bondie/widget/animated_bondie_widget.dart';
import '../../../bondie/pages/stats/bondie_stats_controller.dart';
import '../../../main.dart';
import '../../../bondie/pages/bondie_page.dart';
import 'package:bondedapp/pages/time_capsule/opened/time_capsule_opened_page.dart';

class TimeCapsuleClosedPage extends StatefulWidget {
  final String secretTheme;
  final int daysLeftToOpen;
  final String opensOn;
  final BondieStatsController controller;

  const TimeCapsuleClosedPage({
    super.key,
    required this.controller,
    this.secretTheme = "The days you made me smile the most",
    this.daysLeftToOpen = 10,
    this.opensOn = "November 27",
  });

  @override
  State<TimeCapsuleClosedPage> createState() => _TimeCapsuleClosedPageState();
}

class _TimeCapsuleClosedPageState extends State<TimeCapsuleClosedPage>
    with SingleTickerProviderStateMixin {

  bool _showExplanation = false;

  final int totalCycleDays = 30;

  @override
  Widget build(BuildContext context) {
    final int daysPassed = totalCycleDays - widget.daysLeftToOpen;
    final double progress = (daysPassed / totalCycleDays).clamp(0.0, 1.0);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      bottomNavigationBar: _buildBottomNavBar(context),

      body: AppBackground(
        child: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 30),
                      child: Text(
                        "Time Capsule",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),

                    _buildSecretThemeCard(),
                    const SizedBox(height: 18),

                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => TimeCapsuleOpenedPage(
                                controller: widget.controller,
                                secretTheme: widget.secretTheme,
                              ),
                            ),
                          );
                        },
                        child: Image.asset(
                          "assets/images/bondie_time_capsule/time_capsule_closed.png",
                          height: 220,
                        ),
                      ),
                    ),


                    const SizedBox(height: 20),

                    _buildCapsuleLockedCard(progress, daysPassed),
                    const SizedBox(height: 40),
                  ],
                ),
              ),

              Positioned(
                right: 12,
                top: 10,
                child: GestureDetector(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BondiePage(
                          statsController: widget.controller,
                        ),
                      ),
                    );
                    setState(() {});
                  },
                  child: AnimatedBondieWidget(controller: widget.controller),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSecretThemeCard() {
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _showExplanation = !_showExplanation;
          });
        },
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 360),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.blueGrey.withOpacity(0.10),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.wallet_giftcard_rounded,
                      size: 20, color: Color(0xFF2563EB)),
                  const SizedBox(width: 8),
                  const Text(
                    "Secret Theme",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(width: 3),
                  Icon(
                    _showExplanation
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    size: 22,
                    color: Colors.black54,
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 9),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: const Color(0xFF2563EB),
                    width: 1.8,
                  ),
                ),
                child: Text(
                  '"${widget.secretTheme}"',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                    color: Colors.black87,
                  ),
                ),
              ),

              AnimatedSize(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeInOut,
                child: _showExplanation
                    ? Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    "The Time Capsule is locked. You’ll be able to open and check the submissions on the release date. "
                        "",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13.5,
                      height: 1.35,
                      color: Colors.grey.shade700,
                    ),
                  ),
                )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================
  // CAPSULE LOCKED CARD (sem barra vertical)
  // ============================
  Widget _buildCapsuleLockedCard(double progress, int daysPassed) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.18),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.lock_rounded,
                size: 105,
                color: Color(0xFF2563EB),
              ),
              const SizedBox(width: 18),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Capsule Locked",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: "Opens on: ",
                                style: TextStyle(
                                  fontSize: 15.5,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87,
                                ),
                              ),
                              TextSpan(
                                text: widget.opensOn,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "${widget.daysLeftToOpen} ",
                                style: const TextStyle(
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF2563EB),
                                ),
                              ),
                              const TextSpan(
                                text: "days to go",
                                style: TextStyle(
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF2563EB),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          const Text(
            "Bondie is angry because the submissions are closed until the time capsule opens...",
            style: TextStyle(
              fontSize: 16,
              height: 1.50,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 15),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LinearProgressIndicator(
                value: progress,
                minHeight: 10,
                borderRadius: BorderRadius.circular(12),
                backgroundColor: const Color(0xFFE3EAF7),
                valueColor: const AlwaysStoppedAnimation(Color(0xFF2563EB)),
              ),
              const SizedBox(height: 8),
              Text(
                "Progress: ${((progress * 100).round())}%",
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
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
