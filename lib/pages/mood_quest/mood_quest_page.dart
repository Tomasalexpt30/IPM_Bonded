import 'package:flutter/material.dart';
import 'package:bondedapp/layout/app_background.dart';
import 'package:bondedapp/main.dart'; //

class MoodQuestPage extends StatefulWidget {
  const MoodQuestPage({super.key});

  @override
  State<MoodQuestPage> createState() => _MoodQuestPageState();
}

class _MoodQuestPageState extends State<MoodQuestPage> {
  final PageController _pageController = PageController();

  int currentPage = 0;

  int connectionIndex = -1;
  int energyIndex = -1;
  int affectionIndex = -1;

  void nextPage() {
    if (currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void submit() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => MainScreen()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Mood Quest",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "${currentPage + 1}/3",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: LinearProgressIndicator(
                        value: (currentPage + 1) / 3,
                        backgroundColor: Colors.black12.withOpacity(0.08),
                        color: const Color(0xFF2563EB),
                        minHeight: 6,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: PageView(
                  physics: const BouncingScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (i) => setState(() => currentPage = i),
                  children: [
                    _questionPage(
                      title:
                      "If your connection with your boyfriend were the moon tonight, how would it look?",
                      options: [
                        MoodItem("Low", "🌑"),
                        MoodItem("Growing", "🌒"),
                        MoodItem("Balanced", "🌓"),
                        MoodItem("Strong", "🌕"),
                      ],
                      selectedIndex: connectionIndex,
                      onSelect: (i) => setState(() => connectionIndex = i),
                      onNext: nextPage,
                    ),

                    _questionPage(
                      title:
                      "If your day had a tension meter, how high would it be?",
                      options: [
                        MoodItem("Very tense", "😡"),
                        MoodItem("A bit stressed", "😣"),
                        MoodItem("Mostly calm", "🙂"),
                        MoodItem("Very relaxed", "😇"),
                      ],
                      selectedIndex: energyIndex,
                      onSelect: (i) => setState(() => energyIndex = i),
                      onNext: nextPage,
                    ),

                    _questionPage(
                      title:
                      "If your relationship’s mood today were the weather, what would it be?",
                      options: [
                        MoodItem("Raining", "🌧️"),
                        MoodItem("Cloudy", "⛅"),
                        MoodItem("Sunny", "☀️"),
                        MoodItem("Rainbow", "🌈"),
                      ],
                      selectedIndex: affectionIndex,
                      onSelect: (i) => setState(() => affectionIndex = i),
                      onNext: submit,
                      isLast: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _questionPage({
    required String title,
    required List<MoodItem> options,
    required int selectedIndex,
    required Function(int) onSelect,
    required Function() onNext,
    bool isLast = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26),
      child: Column(
        children: [
          const SizedBox(height: 10),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 100,
                child: Image.asset(
                  "assets/images/bondie_icons/bondie_talking.png",
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 12),

              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueGrey.withOpacity(0.18),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      height: 1.35,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 45),

          Wrap(
            alignment: WrapAlignment.center,
            spacing: 18,
            runSpacing: 18,
            children: List.generate(options.length, (i) {
              final selected = selectedIndex == i;

              return GestureDetector(
                onTap: () => onSelect(i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 140,
                  height: 145,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      color: selected
                          ? const Color(0xFF2563EB)
                          : Colors.black12.withOpacity(0.2),
                      width: selected ? 3 : 1.4,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12.withOpacity(0.06),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(options[i].emoji,
                          style: const TextStyle(fontSize: 42)),
                      const SizedBox(height: 14),
                      Text(
                        options[i].label,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),

          const Spacer(),

          GestureDetector(
            onTap: selectedIndex == -1 ? null : onNext,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: selectedIndex == -1 ? 0.5 : 1,
              child: Container(
                width: double.infinity,
                padding:
                const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF2563EB),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Center(
                  child: Text(
                    isLast ? "Submit" : "Next",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class MoodItem {
  final String label;
  final String emoji;
  MoodItem(this.label, this.emoji);
}
