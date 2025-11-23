import 'package:flutter/material.dart';
import 'package:bondedapp/layout/app_background.dart';
import 'package:bondedapp/bondie/widget/animated_bondie_widget.dart';
import '../../../bondie/pages/stats/bondie_stats_controller.dart';
import '../../../main.dart';
import '../../../bondie/pages/bondie_page.dart';


class TimeCapsuleSubmissionPage extends StatefulWidget {
  final String secretTheme;
  final int daysLeft;
  final BondieStatsController controller;

  const TimeCapsuleSubmissionPage({
    super.key,
    required this.controller,
    this.secretTheme = "The days you made me smile",
    this.daysLeft = 2,
  });

  @override
  State<TimeCapsuleSubmissionPage> createState() =>
      _TimeCapsuleSubmissionPageState();
}

class _TimeCapsuleSubmissionPageState extends State<TimeCapsuleSubmissionPage>
    with SingleTickerProviderStateMixin {
  bool _showExplanation = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),

      bottomNavigationBar: _buildBottomNavBar(context),

      body: AppBackground(
        child: SafeArea(
          child: Stack(
            children: [
              // ================================
              // PAGE CONTENT
              // ================================
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ---------------------------------
                    // TITLE (EXACTO AO HOME)
                    // ---------------------------------
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

                    // ---------------------------------
                    // SECRET THEME — CENTRADO + EXPLICACAO
                    // ---------------------------------
                    Align(
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
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 18,
                          ),
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
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Linha principal + seta
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.wallet_giftcard_rounded,
                                    size: 20,
                                    color: Color(0xFF2563EB),
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    "Secret Theme",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
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

                              // Nome do tema
                              Container(
                                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 9),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  border: Border.all(
                                    color: Color(0xFF2563EB), // cor do cadeado
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


                              // Explicação expandida
                              AnimatedSize(
                                duration: const Duration(milliseconds: 220),
                                curve: Curves.easeInOut,
                                child: _showExplanation
                                    ? Padding(
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                  ),
                                  child: Text(
                                    "Each of you adds a memory that fits this secret theme. "
                                        "All entries stay hidden until the capsule opens at the end of the month.",
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
                    ),

                    const SizedBox(height: 25),

                    // IMAGE
                    Center(
                      child: Image.asset(
                        "assets/images/bondie_time_capsule/time_capsule_submission.png",
                        height: 220,
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Buttons
                    _submissionButton(
                      label: "UPLOAD NOTE",
                      icon: Icons.message_rounded,
                      onTap: () {},
                    ),
                    const SizedBox(height: 16),

                    _submissionButton(
                      label: "UPLOAD PHOTO",
                      icon: Icons.photo_camera_rounded,
                      onTap: () {},
                    ),
                    const SizedBox(height: 16),

                    _submissionButton(
                      label: "UPLOAD VIDEO",
                      icon: Icons.videocam,
                      onTap: () {},
                    ),


                    const SizedBox(height: 40),
                  ],
                ),
              ),

              // ================================
              // FLOATING BONDIE (EXACT LIKE HOME)
              // ================================
              Positioned(
                right: 12,
                top: 10,
                child: GestureDetector(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BondiePage(statsController: widget.controller),
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

  // ==========================================================================
  // SUBMISSION BUTTON
  // ==========================================================================
  Widget _submissionButton({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey.withOpacity(0.12),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 4),
            const Icon(
              Icons.circle, // placeholder invisível para alinhamento, se quiseres
              size: 0,
              color: Colors.transparent,
            ),
            Icon(
              icon,
              size: 24,
              color: const Color(0xFF2563EB),
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================================
  // BOTTOM NAV BAR
  // ==========================================================================
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
