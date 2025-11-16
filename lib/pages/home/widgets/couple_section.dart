import 'package:flutter/material.dart';

class CoupleSection extends StatelessWidget {
  const CoupleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 20),
      child: Column(
        children: [
          const Text(
            "Bruno & Ana",
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              CircleAvatar(
                  radius: 38,
                  backgroundImage: AssetImage('assets/images/user1.png')),
              // logo da app
              Image(
                image: AssetImage('assets/images/bonded_logo.png'),
                height: 36,
              ),
              CircleAvatar(
                  radius: 38,
                  backgroundImage: AssetImage('assets/images/user2.png')),
            ],
          ),
          const SizedBox(height: 20),
          Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bolt, color: Color(0xFF2595DA), size: 22),
                  SizedBox(width: 6),
                  Text(
                    "Bond Level: 82%",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 9,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(color: Colors.grey[300]),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: 0.82,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF93C9FA), // original claro
                            Color(0xFF5AB5F1), // original médio
                            Color(0xFF2F8DCB), // transição suavizada
                            Color(0xFF1E7AB3), // original escuro
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
