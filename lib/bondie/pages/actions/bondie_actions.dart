import 'package:flutter/material.dart';
import '../actions/recommendations/recommendations_page.dart';
import '../stats/bondie_stats_controller.dart';

class BondieActions extends StatelessWidget {
  final BondieStatsController controller;

  const BondieActions({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _actionCard(
          title: "Recommendations",
          icon: Icons.lightbulb_outline_rounded,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => RecommendationsPage(controller: controller),
              ),
            );
          },
        ),
        const SizedBox(height: 18),

        _actionCard(
          title: "Insights",
          icon: Icons.insights_rounded,
          onTap: () {},
        ),
        const SizedBox(height: 18),

        _actionCard(
          title: "Bondie Shop",
          icon: Icons.storefront_rounded,
          onTap: () {},
        ),
      ],
    );
  }

  Widget _actionCard({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey.withOpacity(0.12),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 28, color: const Color(0xFF2595DA)),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 18,
              color: Colors.black45,
            ),
          ],
        ),
      ),
    );
  }
}
