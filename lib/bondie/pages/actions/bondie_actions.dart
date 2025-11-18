import 'package:flutter/material.dart';

class BondieActions extends StatelessWidget {
  const BondieActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _actionCard(
          title: "Recommendations",
          icon: Icons.lightbulb_outline_rounded,
        ),
        const SizedBox(height: 18),
        _actionCard(
          title: "Insights",
          icon: Icons.insights_rounded,
        ),
        const SizedBox(height: 18),
        _actionCard(
          title: "Bondie Shop",
          icon: Icons.storefront_rounded,
        ),
      ],
    );
  }

  Widget _actionCard({
    required String title,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: () {},
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
