import 'package:flutter/material.dart';
import 'bondie_shop_sheets.dart';

class BondieShopGrid extends StatelessWidget {
  final List<Map<String, dynamic>> skins;

  final String selectedFilter;
  final String selectedSort;

  final Set<int> purchased;
  final int? equippedIndex;
  final int coins;

  final Color Function(String rarity) rarityColor;

  final Function(int index) onEquip;
  final Function(int index, int price) onBuy;
  final Function() onNotEnoughCoins;

  const BondieShopGrid({
    super.key,
    required this.skins,
    required this.selectedFilter,
    required this.selectedSort,
    required this.purchased,
    required this.equippedIndex,
    required this.coins,
    required this.rarityColor,
    required this.onEquip,
    required this.onBuy,
    required this.onNotEnoughCoins,
  });

  @override
  Widget build(BuildContext context) {
    List<int> indices = List<int>.generate(skins.length, (i) => i);

    // FILTER
    if (selectedFilter != "All") {
      indices =
          indices.where((i) => skins[i]["rarity"] == selectedFilter).toList();
    }

    // SORT
    indices.sort((a, b) {
      final skinA = skins[a];
      final skinB = skins[b];

      switch (selectedSort) {
        case "Price: Low to High":
          return (skinA["price"] as int).compareTo(skinB["price"] as int);

        case "Price: High to Low":
          return (skinB["price"] as int).compareTo(skinA["price"] as int);

        case "Rarity":
          const order = {
            "Default": -1,
            "Common": 0,
            "Rare": 1,
            "Epic": 2,
            "Legendary": 3,
          };
          return (order[skinA["rarity"]] ?? 0)
              .compareTo(order[skinB["rarity"]] ?? 0);

        case "Name A-Z":
          return (skinA["name"] as String)
              .toLowerCase()
              .compareTo((skinB["name"] as String).toLowerCase());

        case "Name Z-A":
          return (skinB["name"] as String)
              .toLowerCase()
              .compareTo((skinA["name"] as String).toLowerCase());
      }

      return 0;
    });

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: indices.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: 0.72,
      ),
      itemBuilder: (context, i) {
        final realIndex = indices[i];
        return _skinCard(context, realIndex);
      },
    );
  }

  // ============================================================
  // SKIN CARD
  // ============================================================
  Widget _skinCard(BuildContext context, int index) {
    final skin = skins[index];

    final bool isDefault = index == 0;

    // Default is equipped when equippedIndex is null
    final bool isEquipped = (equippedIndex ?? 0) == index;

    final bool isPurchased = purchased.contains(index);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: isEquipped
            ? Border.all(color: const Color(0xFF3B82F6), width: 1.6)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(isEquipped ? 0.20 : 0.12),
            blurRadius: isEquipped ? 16 : 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // RARITY BADGE
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: isDefault
                  ? Colors.transparent
                  : rarityColor(skin["rarity"]).withOpacity(0.20),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              skin["rarity"],
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: isDefault ? Colors.black87 : rarityColor(skin["rarity"]),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // SKIN IMAGE
          Expanded(
            flex: 3,
            child: Image.asset(
              skin["asset"],
              fit: BoxFit.contain,
            ),
          ),

          const SizedBox(height: 8),

          // NAME
          Text(
            skin["name"],
            textAlign: TextAlign.center,
            maxLines: 2,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 4),

          // DESCRIPTION
          Text(
            skin["desc"],
            textAlign: TextAlign.center,
            maxLines: 2,
            style: const TextStyle(
              fontSize: 11,
              height: 1.2,
              color: Colors.black54,
            ),
          ),

          const SizedBox(height: 8),

          // PRICE
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.monetization_on_rounded,
                size: 17,
                color: Colors.amber[600],
              ),
              const SizedBox(width: 4),
              Text(
                skin["price"].toString(),
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // BUTTON
          _buildButton(
            context: context,
            index: index,
            isPurchased: isPurchased,
            isEquipped: isEquipped,
            price: skin["price"],
            isDefault: isDefault,
            skinName: skin["name"],
            skinAsset: skin["asset"],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // BUY / EQUIP / EQUIPPED BUTTON
  // ============================================================
  Widget _buildButton({
    required BuildContext context,
    required int index,
    required bool isPurchased,
    required bool isEquipped,
    required int price,
    required bool isDefault,
    required String skinName,
    required String skinAsset,
  }) {
    // DEFAULT SKIN
    if (isDefault) {
      if (isEquipped) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 7),
          decoration: BoxDecoration(
            color: const Color(0xFF3B82F6).withOpacity(0.15),
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Center(
            child: Text(
              "Equipped",
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: Color(0xFF3B82F6),
              ),
            ),
          ),
        );
      }

      return GestureDetector(
        onTap: () => onEquip(0),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 7),
          decoration: BoxDecoration(
            color: const Color(0xFF64A822).withOpacity(0.15),
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Center(
            child: Text(
              "Equip",
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: Color(0xFF64A822),
              ),
            ),
          ),
        ),
      );
    }

    // BUY
    if (!isPurchased) {
      return GestureDetector(
        onTap: () {
          if (coins >= price) {
            showConfirmBuySheet(
              context: context,
              skinName: skinName,
              skinAsset: skinAsset,
              price: price,
              onConfirm: () => onBuy(index, price),
            );
          } else {
            onNotEnoughCoins();
          }
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 7),
          decoration: BoxDecoration(
            color: const Color(0xFFFFA000).withOpacity(0.15),
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Center(
            child: Text(
              "Buy",
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: Color(0xFFFFA000),
              ),
            ),
          ),
        ),
      );
    }

    // EQUIPPED
    if (isEquipped) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 7),
        decoration: BoxDecoration(
          color: const Color(0xFF3B82F6).withOpacity(0.15),
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Center(
          child: Text(
            "Equipped",
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: Color(0xFF3B82F6),
            ),
          ),
        ),
      );
    }

    // EQUIP
    return GestureDetector(
      onTap: () => onEquip(index),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 7),
        decoration: BoxDecoration(
          color: const Color(0xFF64A822).withOpacity(0.15),
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Center(
          child: Text(
            "Equip",
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: Color(0xFF64A822),
            ),
          ),
        ),
      ),
    );
  }
}
