import 'package:flutter/material.dart';

void main() {
  runApp(const BondedApp());
}

class BondedApp extends StatelessWidget {
  const BondedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bonded',
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: const Color(0xFFF8F9FD),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3B82F6),
          secondary: const Color(0xFF06B6D4),
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MainScreen(),
    );
  }
}

// =====================================
// MAIN SCREEN
// =====================================
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    const ModernHomePage(),
    const Center(child: Text('📅 Calendar Page')),
    const Center(child: Text('💬 Messages')),
    const Center(child: Text('👤 Profile')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _pages[_selectedIndex],
          const Positioned(
            right: 12,
            top: 60,
            child: AnimatedBondieWidget(),
          ),
        ],
      ),
      bottomNavigationBar: Container(
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
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: const Color(0xFF2595DA),
          unselectedItemColor: Colors.grey[500],
          showUnselectedLabels: true,
          iconSize: 30,
          selectedFontSize: 14,
          unselectedFontSize: 13,
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
              icon: Icon(Icons.chat_bubble_outline_rounded),
              label: 'Messages',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================
// HOME PAGE (com Time Capsule integrada)
// =====================================
class ModernHomePage extends StatefulWidget {
  const ModernHomePage({super.key});

  @override
  State<ModernHomePage> createState() => _ModernHomePageState();
}

class _ModernHomePageState extends State<ModernHomePage> {
  bool isOpen = false;
  DateTime now = DateTime.now();
  DateTime openDate = DateTime.now().add(const Duration(hours: 10));
  DateTime closeDate = DateTime.now().add(const Duration(hours: 20));
  String theme = "Secret Theme: Anniversary Memories";

  String getTimeRemaining() {
    final target = isOpen ? closeDate : openDate;
    final diff = target.difference(now);
    if (diff.isNegative) return "00:00:00";
    final hours = diff.inHours.remainder(24).toString().padLeft(2, '0');
    final minutes = diff.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = diff.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }

  @override
  void initState() {
    super.initState();
    // Atualiza contador da cápsula do tempo
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      setState(() => now = DateTime.now());
      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      body: Stack(
        children: [
          // Fundo suave
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFF8FAFF), Color(0xFFE9F1FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // 💙 Corações decorativos (mesma cor e tamanho dos círculos)
          Positioned(top: -45, left: -40, child: _heart(180, Colors.blueAccent.withOpacity(0.15))),
          Positioned(top: 140, left: -60, child: _heart(250, Colors.blueAccent.withOpacity(0.15))),
          Positioned(top: 60, right: 0, child: _heart(170, Colors.lightBlue.withOpacity(0.12))),
          Positioned(top: 200, left: 220, child: _heart(50, Colors.blue.withOpacity(0.08))),
          Positioned(top: 300, left: 180, child: _heart(90, Colors.blue.withOpacity(0.08))),
          Positioned(top: 420, left: 30, child: _heart(120, Colors.blueAccent.withOpacity(0.12))),
          Positioned(bottom: 145, right: -50, child: _heart(220, Colors.lightBlue.withOpacity(0.12))),
          Positioned(top: 220, right: -80, child: _heart(160, Colors.indigoAccent.withOpacity(0.15))),
          Positioned(bottom: -50, left: -50, child: _heart(200, Colors.lightBlue.withOpacity(0.12))),
          Positioned(bottom: 150, left: 140, child: _heart(70, Colors.indigoAccent.withOpacity(0.10))),
          Positioned(bottom: -150, right: -50, child: _heart(270, Colors.blueAccent.withOpacity(0.15))),

          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🔹 Home title
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

                    // 💞 Couple section
                    _coupleSection(),

                    const SizedBox(height: 35),

                    // 🌤️ Daily activity
                    _dailyActivity(),

                    const SizedBox(height: 35),

                    // 🕒 Time Capsule integrada
                    _timeCapsule(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ❤️ Função para desenhar corações
  static Widget _heart(double size, Color color) => CustomPaint(
    size: Size(size, size),
    painter: _HeartPainter(color),
  );

  Widget _timeCapsule() => Container(
    width: double.infinity,
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFFDBEAFE), Color(0xFF96D5FD)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(22),
      boxShadow: [
        BoxShadow(
          color: Colors.blueGrey.withOpacity(0.35),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
    child: Stack(
      children: [
        Positioned(
          top: 0,
          right: 10,
          child: Icon(
            isOpen ? Icons.lock_open_rounded : Icons.lock_rounded,
            color: const Color(0xDD000000),
            size: 28,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                SizedBox(width: 8),
                Text(
                  "Time Capsule",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF78BCE9), width: 2),
                borderRadius: BorderRadius.circular(18),
                color: Colors.white.withOpacity(0.8),
              ),
              child: Center(
                child: Text(
                  theme,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2595DA),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Opens in: ",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  getTimeRemaining(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    color: Color(0xFF165D88),
                    fontFamily: 'RobotoMono',
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  Widget _coupleSection() => Container(
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
          children: [
            const CircleAvatar(radius: 38, backgroundImage: AssetImage('assets/images/user1.png')),
            Image.asset('assets/images/bonded_logo.png', height: 36),
            const CircleAvatar(radius: 38, backgroundImage: AssetImage('assets/images/user2.png')),
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
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 8,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(color: Colors.grey[300]),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: 0.82,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF1E7AB3), Color(0xFF78BCE9)],
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

  Widget _dailyActivity() => Container(
    width: double.infinity,
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFFDBEAFE), Color(0xFF96D5FD)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(22),
      boxShadow: [
        BoxShadow(
          color: Colors.blueGrey.withOpacity(0.35),
          blurRadius: 8,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(width: 8),
            Text(
              "Daily Activity",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        SizedBox(height: 14),
        Text(
          "Write each other a small note saying what you appreciated most today",
          style: TextStyle(
            fontSize: 16,
            color: Colors.black87,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

// =====================================
// 💙 Heart Painter (para o fundo)
// =====================================
class _HeartPainter extends CustomPainter {
  final Color color;
  _HeartPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color..style = PaintingStyle.fill;
    final path = Path();
    final w = size.width;
    final h = size.height;

    // Desenha um coração simétrico
    path.moveTo(w / 2, h * 0.75);
    path.cubicTo(-w * 0.2, h * 0.35, w * 0.25, -h * 0.2, w / 2, h * 0.25);
    path.cubicTo(w * 0.75, -h * 0.2, w * 1.2, h * 0.35, w / 2, h * 0.75);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =====================================
// 🩵 Bondie animado
// =====================================
class AnimatedBondieWidget extends StatefulWidget {
  const AnimatedBondieWidget({super.key});

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
        'assets/images/bondie_logo.png',
        width: 85,
        height: 85,
        fit: BoxFit.contain,
      ),
    );
  }
}
