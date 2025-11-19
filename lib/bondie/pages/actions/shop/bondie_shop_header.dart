import 'package:flutter/material.dart';

class BondieShopHeader extends StatelessWidget {
  final int coins;
  final String selectedSort;
  final String selectedFilter;
  final int? equippedIndex;

  final List<Map<String, dynamic>> skins;

  final Color Function(String rarity) rarityColor;

  final VoidCallback onOpenSort;
  final VoidCallback onOpenFilter;
  final VoidCallback onOpenCoins;

  const BondieShopHeader({
    super.key,
    required this.coins,
    required this.selectedSort,
    required this.selectedFilter,
    required this.equippedIndex,
    required this.skins,
    required this.rarityColor,
    required this.onOpenSort,
    required this.onOpenFilter,
    required this.onOpenCoins,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTopBar(context),
        const SizedBox(height: 20),
        _buildBondiePreview(),
        const SizedBox(height: 16),
        _buildSortFilterRow(),
      ],
    );
  }

  // ============================================================
  // TOP BAR
  // ============================================================
  Widget _buildTopBar(BuildContext context) {
    return SizedBox(
      height: 44,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // SETA À ESQUERDA
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back_rounded, size: 26),
            ),
          ),

          // TÍTULO CENTRADO
          const Align(
            alignment: Alignment.center,
            child: Text(
              "Bondie Shop",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          // MOEDAS À DIREITA
          Align(
            alignment: Alignment.centerRight,
            child: _buildCoinsChip(),
          ),
        ],
      ),
    );
  }

  Widget _buildCoinsChip() {
    return GestureDetector(
      onTap: onOpenCoins,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(999),
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.monetization_on_rounded,
              size: 18,
              color: Colors.amber[600],
            ),
            const SizedBox(width: 6),
            Text(
              coins.toString(),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // PREVIEW BASED ON EQUIPPED SKIN
  // ============================================================
  Widget _buildBondiePreview() {
    final bool isDefault = equippedIndex == null || equippedIndex == 0;

    final String previewAsset = isDefault
        ? "assets/images/bondie_icons/bondie_talking.png"
        : skins[equippedIndex!]["asset"];

    final String previewName =
    isDefault ? "Default Bondie" : skins[equippedIndex!]["name"];

    final String previewDesc = isDefault
        ? "The original and cozy version of Bondie."
        : skins[equippedIndex!]["desc"];

    return Container(
      padding: const EdgeInsets.all(18),
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
      child: Row(
        children: [
          Image.asset(
            previewAsset,
            height: 125,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Current Skin",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  previewName,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  previewDesc,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.2,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SORT + FILTER
  // ============================================================
  Widget _buildSortFilterRow() {
    return Row(
      children: [
        _buildSortChip(),
        const Spacer(),
        _buildFilterChip(),
      ],
    );
  }

  // ============================================================
  // SORT CHIP
  // ============================================================
  Widget _buildSortChip() {
    return GestureDetector(
      onTap: onOpenSort,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.sort_rounded, size: 18, color: Colors.black54),
            const SizedBox(width: 6),
            Text(
              selectedSort,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.expand_more_rounded,
                size: 18, color: Colors.black54),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // FILTER CHIP
  // ============================================================
  Widget _buildFilterChip() {
    final bool hasFilter = selectedFilter != "All";

    final Color dotColor = selectedFilter == "Default"
        ? Colors.black54
        : hasFilter
        ? rarityColor(selectedFilter)
        : Colors.black45;

    return GestureDetector(
      onTap: onOpenFilter,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.filter_list_rounded,
                size: 18, color: Colors.black54),
            const SizedBox(width: 6),
            Text(
              "Filter by",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: hasFilter ? dotColor : Colors.black87,
              ),
            ),
            const SizedBox(width: 6),
            Icon(Icons.circle, size: 10, color: dotColor),
            const SizedBox(width: 4),
            const Icon(Icons.expand_more_rounded,
                size: 18, color: Colors.black54),
          ],
        ),
      ),
    );
  }
}
