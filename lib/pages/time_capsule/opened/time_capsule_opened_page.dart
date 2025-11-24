import 'package:flutter/material.dart';
import 'package:bondedapp/layout/app_background.dart';
import 'package:bondedapp/bondie/widget/animated_bondie_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:photo_view/photo_view.dart';

import '../../../bondie/pages/stats/bondie_stats_controller.dart';
import '../../../bondie/pages/bondie_page.dart';
import '../../../main.dart';

class TimeCapsuleOpenedPage extends StatefulWidget {
  final String secretTheme;
  final BondieStatsController controller;

  const TimeCapsuleOpenedPage({
    super.key,
    required this.controller,
    this.secretTheme = "The days you made me smile the most",
  });

  @override
  State<TimeCapsuleOpenedPage> createState() => _TimeCapsuleOpenedPageState();
}

class _TimeCapsuleOpenedPageState extends State<TimeCapsuleOpenedPage>
    with SingleTickerProviderStateMixin {
  bool _showExplanation = false;

  static const String samplePhoto =
      "assets/images/recommendations/gulbenkian_garden.jpg";

  final List<Map<String, dynamic>> brunoMedia = [
    {"type": "video", "path": "assets/images/submissions/bruno/bruno_submission_2.png"},
    {"type": "photo", "path": "assets/images/submissions/bruno/bruno_submission_1.png"},
    {"type": "photo", "path": "assets/images/submissions/bruno/bruno_submission_3.png"},
    {"type": "photo", "path": "assets/images/submissions/bruno/bruno_submission_4.png"},
    {"type": "video", "path": "assets/images/submissions/bruno/bruno_submission_5.png"},
  ];

  final List<Map<String, dynamic>> anaMedia = [
    {"type": "photo", "path": "assets/images/submissions/ana/ana_submission_2.png"},
    {"type": "video", "path": "assets/images/submissions/ana/ana_submission_1.png"},
    {"type": "photo", "path": "assets/images/submissions/ana/ana_submission_3.png"},
    {"type": "video", "path": "assets/images/submissions/ana/ana_submission_4.png"},
    {"type": "photo", "path": "assets/images/submissions/ana/ana_submission_5.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      bottomNavigationBar: _buildBottomNavBar(),
      body: AppBackground(
        child: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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

                    _secretThemeCard(),
                    const SizedBox(height: 25),

                    Center(
                      child: Image.asset(
                        "assets/images/bondie_time_capsule/time_capsule_opened.png",
                        height: 220,
                      ),
                    ),

                    const SizedBox(height: 27),

                    _submissionsSection(
                      title: "Bruno’s Submissions",
                      subtitle: "Your saved memories",
                      avatar: "assets/images/user1.png",
                      mixedList: brunoMedia,
                      notes: const [
                        "I still remember that afternoon in the gardens, you laughed so much you cried.",
                      ],
                    ),

                    const SizedBox(height: 22),

                    _submissionsSection(
                      title: "Ana’s Submissions",
                      subtitle: "What Ana shared with you",
                      avatar: "assets/images/user2.png",
                      mixedList: anaMedia,
                      notes: const [
                        "You made me smile every single week, especially the sushi night",
                      ],
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),

              Positioned(
                right: 12,
                top: 10,
                child: GestureDetector(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            BondiePage(statsController: widget.controller),
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

  Widget _secretThemeCard() {
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
          setState(() => _showExplanation = !_showExplanation);
        },
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 360),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 18),
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
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.wallet_giftcard_rounded,
                      size: 20, color: Color(0xFF2563EB)),
                  const SizedBox(width: 8),
                  const Text(
                    "Secret Theme",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
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
              Container(
                padding:
                const EdgeInsets.symmetric(vertical: 6, horizontal: 9),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFF2563EB), width: 1.8),
                ),
                child: Text(
                  '"${widget.secretTheme}"',
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 220),
                child: _showExplanation
                    ? Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    "The capsule has opened! Both of you added memories following this theme.",
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
    );
  }

  Widget _statsHeader({
    required int photos,
    required int videos,
    required int notes,
  }) {
    const style = TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w700,
      color: Colors.black87,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.photo_rounded, size: 18, color: Color(0xFF2563EB)),
        const SizedBox(width: 3),
        Text("$photos", style: style),
        const SizedBox(width: 12),

        const Icon(Icons.videocam_rounded, size: 18, color: Color(0xFF2563EB)),
        const SizedBox(width: 3),
        Text("$videos", style: style),
        const SizedBox(width: 12),

        const Icon(Icons.sticky_note_2_rounded,
            size: 18, color: Color(0xFF2563EB)),
        const SizedBox(width: 3),
        Text("$notes", style: style),
      ],
    );
  }

  Widget _submissionsSection({
    required String title,
    required String subtitle,
    required String avatar,
    required List<Map<String, dynamic>> mixedList,
    required List<String> notes,
  }) {
    final photos = mixedList.where((m) => m["type"] == "photo").length;
    final videos = mixedList.where((m) => m["type"] == "video").length;
    final noteCount = notes.length;

    return Container(
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
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: _statsHeader(
                  photos: photos,
                  videos: videos,
                  notes: noteCount,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Masonry
          _mixedMosaic(mixedList),
          const SizedBox(height: 16),

          // Notes
          for (final note in notes) ...[
            _noteSpeechBubble(text: note, avatar: avatar),
            const SizedBox(height: 14),
          ],
        ],
      ),
    );
  }

  Widget _mixedMosaic(List<Map<String, dynamic>> items) {
    return MasonryGridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final media = items[index];
        final bool tall = index % 3 == 0;

        return GestureDetector(
          onTap: () => _openFullImage(media["path"], index,
              isVideo: media["type"] == "video"),
          child: Hero(
            tag: "media_${media["path"]}_$index",
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                children: [
                  Transform.scale(
                    scale: 1.5,
                    child: Image.asset(
                      media["path"],
                      height: tall ? 160 : 101,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  if (media["type"] == "video")
                    Container(
                      height: tall ? 160 : 110,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.25),
                      ),
                    ),

                  if (media["type"] == "video")
                    const Positioned.fill(
                      child: Center(
                        child: Icon(
                          Icons.play_circle_fill_rounded,
                          size: 42,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _noteSpeechBubble({
    required String text,
    required String avatar,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage(avatar),
        ),
        const SizedBox(width: 10),

        Expanded(
          child: Container(
            padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFEAF2FF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                height: 1.42,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _openFullImage(String path, int index, {required bool isVideo}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => _FullscreenImagePage(
          imagePath: path,
          heroTag: "media_${path}_$index",
          isVideo: isVideo,
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
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

class _FullscreenImagePage extends StatelessWidget {
  final String imagePath;
  final String heroTag;
  final bool isVideo;

  const _FullscreenImagePage({
    required this.imagePath,
    required this.heroTag,
    required this.isVideo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: Hero(
            tag: heroTag,
            child: PhotoView(
              imageProvider: AssetImage(imagePath),
              backgroundDecoration:
              const BoxDecoration(color: Colors.transparent),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 2,
            ),
          ),
        ),
      ),
    );
  }
}
