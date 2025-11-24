import 'package:flutter/material.dart';
import '../pages/stats/bondie_stats_controller.dart';

class AnimatedBondieWidget extends StatefulWidget {
  final BondieStatsController controller;

  const AnimatedBondieWidget({
    super.key,
    required this.controller,
  });

  @override
  State<AnimatedBondieWidget> createState() => _AnimatedBondieWidgetState();
}

class _AnimatedBondieWidgetState extends State<AnimatedBondieWidget>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: 0, end: -6).animate(
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
    return AnimatedBuilder(
      animation: _floatAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _floatAnimation.value),
          child: child,
        );
      },
      child: Image.asset(
        widget.controller.bondieImage,
        width: 85,
        height: 85,
        fit: BoxFit.contain,
      ),
    );
  }
}
