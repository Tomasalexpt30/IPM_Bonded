import 'package:flutter/material.dart';

class CalendarFeedback {
  static void show(
      BuildContext context,
      String message, {
        IconData icon = Icons.check_circle_rounded,
      }) {
    final overlay = Overlay.of(context);
    if (overlay == null) return;

    final entry = OverlayEntry(
      builder: (_) => _FeedbackPopup(
        message: message,
        icon: icon,
      ),
    );

    overlay.insert(entry);

    Future.delayed(const Duration(milliseconds: 1600)).then((_) {
      entry.remove();
    });
  }
}

class _FeedbackPopup extends StatefulWidget {
  final String message;
  final IconData icon;

  const _FeedbackPopup({
    required this.message,
    required this.icon,
  });

  @override
  State<_FeedbackPopup> createState() => _FeedbackPopupState();
}

class _FeedbackPopupState extends State<_FeedbackPopup>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> opacity;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );

    opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOut),
    );

    controller.forward();

    Future.delayed(const Duration(milliseconds: 1200)).then((_) {
      if (mounted) controller.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: Center(
          child: FadeTransition(
            opacity: opacity,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 26,
                vertical: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.10),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    widget.icon,
                    size: 32,
                    color: const Color(0xFF2563EB),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.message,
                    style: const TextStyle(
                      fontFamily: "Poppins",   // 🔥 mesma fonte da app
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                      decoration: TextDecoration.none, // 🔥 remove underline amarelo do debug
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
