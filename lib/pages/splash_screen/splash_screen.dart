import 'package:flutter/material.dart';
import 'package:bondedapp/pages/mood_quest/mood_quest_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {

  late AnimationController _growController;
  late Animation<double> _growAnimation;

  @override
  void initState() {
    super.initState();
    _growController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );

    _growAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _growController,
        curve: Curves.easeOutQuart,
      ),
    );

    _growController.forward();

    Future.delayed(const Duration(milliseconds: 3200), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MoodQuestPage()),
      );
    });
  }

  @override
  void dispose() {
    _growController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedBuilder(
        animation: _growController,
        builder: (_, __) {
          final double scale = _growAnimation.value;

          return Center(
            child: Transform.scale(
              scale: scale,
              child: SizedBox(
                width: 200,
                child: Image.asset(
                  "assets/images/bonded_logo.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
