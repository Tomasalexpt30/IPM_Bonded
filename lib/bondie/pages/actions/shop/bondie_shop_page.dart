import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import '../../../../main.dart';
import 'sections/bondie_shop_header.dart';
import 'sections/bondie_shop_grid.dart';
import 'sections/bondie_shop_sheets.dart';
import 'package:bondedapp/layout/app_background.dart';

class BondieShopPage extends StatefulWidget {
  const BondieShopPage({super.key});

  @override
  State<BondieShopPage> createState() => _BondieShopPageState();
}

class _BondieShopPageState extends State<BondieShopPage> {
  // 🎉 CONFETTI CONTROLLER
  late ConfettiController _confettiController;

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
      "desc": "Puts out any toxic flames, only love remains."
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

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

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
      bottomNavigationBar: _buildBottomNavBar(),

      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          AppBackground(
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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

                          _confettiController.play();
                        },

                        onNotEnoughCoins: () =>
                            showNotEnoughCoinsSheet(context: context),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // 🎉 CONFETTI WIDGET
          ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            emissionFrequency: 0.10,
            numberOfParticles: 25,
            maxBlastForce: 18,
            minBlastForce: 8,
            gravity: 0.6,
            colors: const [
              Colors.blue,
              Colors.red,
              Colors.green,
              Colors.yellow,
              Colors.purple,
              Colors.orange,
            ],
          ),
        ],
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
