import 'package:flutter/material.dart';
import 'bondie_shop_header.dart';
import 'bondie_shop_grid.dart';
import 'bondie_shop_sheets.dart';

class BondieShopPage extends StatefulWidget {
  const BondieShopPage({super.key});

  @override
  State<BondieShopPage> createState() => _BondieShopPageState();
}

class _BondieShopPageState extends State<BondieShopPage> {
  String selectedSort = "Price: Low to High";
  String selectedFilter = "All";

  final List<Map<String, dynamic>> skins = [
    {
      "name": "Default Bondie",
      "asset": "assets/images/bondie_icons/bondie_talking.png",
      "price": 0,
      "rarity": "Default",
      "desc": "The classic and original version of Bondie."
    },
    {
      "name": "Chef Bondie",
      "asset": "assets/images/bondie_skins/bondie_cook.png",
      "price": 120,
      "rarity": "Common",
      "desc": "Bondie ready to cook something special."
    },
    {
      "name": "Police Bondie",
      "asset": "assets/images/bondie_skins/bondie_cop.png",
      "price": 140,
      "rarity": "Rare",
      "desc": "Always protecting the love in your relationship."
    },
    {
      "name": "Doctor Bondie",
      "asset": "assets/images/bondie_skins/bondie_doctor.png",
      "price": 160,
      "rarity": "Epic",
      "desc": "Heals hearts and strengthens the bond between you."
    },
    {
      "name": "Fireman Bondie",
      "asset": "assets/images/bondie_skins/bondie_firefighter.png",
      "price": 150,
      "rarity": "Rare",
      "desc": "Puts out any toxic flames — only love remains."
    },
    {
      "name": "Nerd Bondie",
      "asset": "assets/images/bondie_skins/bondie_nerd.png",
      "price": 110,
      "rarity": "Common",
      "desc": "A geek passionate about learning more about love."
    },
    {
      "name": "Pirate Bondie",
      "asset": "assets/images/bondie_skins/bondie_pirate.png",
      "price": 130,
      "rarity": "Epic",
      "desc": "Searching for the greatest treasure: your relationship."
    },
    {
      "name": "Santa Bondie",
      "asset": "assets/images/bondie_skins/bondie_santa.png",
      "price": 170,
      "rarity": "Legendary",
      "desc": "Spreads magic, warmth, and a cozy holiday spirit."
    },
    {
      "name": "Soccer Bondie",
      "asset": "assets/images/bondie_skins/bondie_soccer.png",
      "price": 140,
      "rarity": "Rare",
      "desc": "Always scoring goals in the field of love."
    },
    {
      "name": "Thief Bondie",
      "asset": "assets/images/bondie_skins/bondie_thief.png",
      "price": 115,
      "rarity": "Common",
      "desc": "Steals smiles without any guilt!"
    },
  ];

  int? equippedIndex;
  Set<int> purchased = {0};
  int coins = 520;

  Color rarityColor(String rarity) {
    switch (rarity) {
      case "Default":
        return const Color(0xFFBFC7D5);
      case "Common":
        return const Color(0xFF64A822);
      case "Rare":
        return const Color(0xFF3B82F6);
      case "Epic":
        return const Color(0xFF8B5CF6);
      case "Legendary":
        return const Color(0xFFF59E0B);
      default:
        return Colors.black54;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      body: Stack(
        children: [
          _buildBackground(),
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BondieShopHeader(
                      coins: coins,
                      selectedSort: selectedSort,
                      selectedFilter: selectedFilter,
                      equippedIndex: equippedIndex,
                      skins: skins,
                      rarityColor: rarityColor,

                      onOpenSort: () => showSortSheet(
                        context: context,
                        selectedSort: selectedSort,
                        onSelect: (value) =>
                            setState(() => selectedSort = value),
                      ),

                      onOpenFilter: () => showFilterSheet(
                        context: context,
                        selectedFilter: selectedFilter,
                        rarityColor: rarityColor,
                        onSelect: (value) =>
                            setState(() => selectedFilter = value),
                      ),

                      onOpenCoins: () => showCoinsSheet(
                        context: context,
                        coins: coins,
                      ),
                    ),

                    const SizedBox(height: 20),

                    BondieShopGrid(
                      skins: skins,
                      selectedFilter: selectedFilter,
                      selectedSort: selectedSort,
                      purchased: purchased,
                      equippedIndex: equippedIndex,
                      coins: coins,
                      rarityColor: rarityColor,

                      onEquip: (i) => setState(() => equippedIndex = i),

                      onBuy: (i, price) {
                        setState(() {
                          coins -= price;
                          purchased.add(i);
                          equippedIndex = i;
                        });
                      },

                      onNotEnoughCoins: () =>
                          showNotEnoughCoinsSheet(context: context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Background + decorative hearts
  Widget _buildBackground() {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF8FAFF), Color(0xFFE9F1FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        ..._hearts(),
      ],
    );
  }

  List<Widget> _hearts() {
    return [
      Positioned(top: -45, left: -40, child: _heart(180, Colors.blueAccent)),
      Positioned(top: 140, left: -60, child: _heart(250, Colors.blueAccent)),
      Positioned(top: 60, right: 0, child: _heart(170, Colors.lightBlue)),
      Positioned(top: 200, left: 220, child: _heart(50, Colors.blue)),
      Positioned(top: 300, left: 180, child: _heart(90, Colors.blue)),
      Positioned(top: 420, left: 30, child: _heart(120, Colors.blueAccent)),
      Positioned(bottom: 145, right: -50, child: _heart(220, Colors.lightBlue)),
      Positioned(bottom: -50, left: -50, child: _heart(200, Colors.lightBlue)),
    ];
  }

  Widget _heart(double size, Color color) {
    return CustomPaint(
      size: Size(size, size),
      painter: _HeartPainter(color.withOpacity(0.08)),
    );
  }
}

class _HeartPainter extends CustomPainter {
  final Color color;
  _HeartPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;

    final path = Path()
      ..moveTo(w / 2, h * 0.75)
      ..cubicTo(-w * 0.2, h * 0.35, w * 0.25, -h * 0.2, w / 2, h * 0.25)
      ..cubicTo(w * 0.75, -h * 0.2, w * 1.2, h * 0.35, w / 2, h * 0.75);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
