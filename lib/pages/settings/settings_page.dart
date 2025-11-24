import 'package:flutter/material.dart';
import 'package:bondedapp/layout/app_background.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),

      body: AppBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(height: 20),

                _buildHeader(),

                const SizedBox(height: 30),

                _profileHeader(),
                const SizedBox(height: 15),
                _profileButtons(),

                const SizedBox(height: 30),

                _sectionTitle("App Settings"),
                const SizedBox(height: 15),

                _settingsCard(
                  icon: Icons.lock_rounded,
                  color: const Color(0xFFF69AB4),
                  title: "Privacy Settings",
                  description: "Manage what you share with Bonded.",
                  onTap: () {},
                ),
                const SizedBox(height: 15),

                _settingsCard(
                  icon: Icons.devices_rounded,
                  color: const Color(0xFFA17BF6),
                  title: "Manage Devices",
                  description: "Check where your account is logged in.",
                  onTap: () {},
                ),
                const SizedBox(height: 15),

                _settingsCard(
                  icon: Icons.language_rounded,
                  color: const Color(0xFF5EC8A7),
                  title: "Language & Region",
                  description: "Choose the app language and region.",
                  onTap: () {},
                ),
                const SizedBox(height: 15),

                _settingsCard(
                  icon: Icons.notifications_rounded,
                  color: const Color(0xFFFFD54F),
                  title: "Notifications",
                  description: "Adjust reminders and alert preferences.",
                  onTap: () {},
                ),
                const SizedBox(height: 15),

                _settingsCard(
                  icon: Icons.color_lens_rounded,
                  color: const Color(0xFFFD912F),
                  title: "Appearance",
                  description: "Control theme, backgrounds, and colors.",
                  onTap: () {},
                ),

                const SizedBox(height: 30),

                _sectionTitle("Support"),
                const SizedBox(height: 15),

                _settingsCard(
                  icon: Icons.help_outline_rounded,
                  color: const Color(0xFF3B82F6),
                  title: "Help & Support",
                  description: "FAQ, tutorials and troubleshooting.",
                  onTap: () {},
                ),
                const SizedBox(height: 15),

                _settingsCard(
                  icon: Icons.mail_rounded,
                  color: const Color(0xFF9CA3AF),
                  title: "Contact Us",
                  description: "Get in touch with the Bonded team.",
                  onTap: () {},
                ),

                const SizedBox(height: 30),

                _sectionTitle("Account Actions"),
                const SizedBox(height: 15),

                _dangerCard(
                  title: "Log Out",
                  icon: Icons.logout_rounded,
                  onTap: () {},
                ),

                const SizedBox(height: 15),

                _dangerCard(
                  title: "Delete Account",
                  icon: Icons.delete_rounded,
                  onTap: () {},
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Text(
      "Settings",
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
        height: 1.1,
      ),
    );
  }

  Widget _profileHeader() {
    return Center(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFF2563EB),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.blueGrey.withOpacity(0.18),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                "assets/images/user1.png",
                height: 115,
                width: 115,
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            "Bruno Alves",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            "brunoalves76@gmail.com",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _profileButtons() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {},
            child: _smallWhiteButton("Edit Profile"),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: GestureDetector(
            onTap: () {},
            child: _smallWhiteButton("Account Details"),
          ),
        ),
      ],
    );
  }

  Widget _smallWhiteButton(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.12),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

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

  Widget _settingsCard({
    required IconData icon,
    required Color color,
    required String title,
    required String description,
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

            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 18,
              color: Colors.black38,
            ),
          ],
        ),
      ),
    );
  }

  Widget _dangerCard({
    required String title,
    required IconData icon,
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
                color: const Color(0xFFFFE5E5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                icon,
                size: 28,
                color: const Color(0xFFE53935),
              ),
            ),

            const SizedBox(width: 18),

            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE53935),
                ),
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 18,
              color: Colors.black38,
            ),
          ],
        ),
      ),
    );
  }
}
