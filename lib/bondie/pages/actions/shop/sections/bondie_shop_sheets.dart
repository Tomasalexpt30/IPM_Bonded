import 'package:flutter/material.dart';

// ============================================================
// SORT SHEET
// ============================================================
Future<void> showSortSheet({
  required BuildContext context,
  required String selectedSort,
  required Function(String) onSelect,
}) {
  final options = [
    "Price: Low to High",
    "Price: High to Low",
    "Rarity",
    "Name A-Z",
    "Name Z-A",
  ];

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
    ),
    builder: (_) {
      return SafeArea(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.65,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Column(
                children: [
                  Container(
                    height: 5,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    "Sort skins",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Choose how you want to organize Bondie’s outfits.",
                    style: TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                  const SizedBox(height: 10),

                  ...options.map((o) {
                    final bool isActive = selectedSort == o;
                    return ListTile(
                      leading: Icon(
                        o.contains("Price")
                            ? Icons.monetization_on_rounded
                            : o == "Rarity"
                            ? Icons.auto_awesome_rounded
                            : Icons.sort_by_alpha_rounded,
                        color: isActive ? const Color(0xFF2563EB) : Colors.black45,
                      ),
                      title: Text(
                        o,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight:
                          isActive ? FontWeight.w700 : FontWeight.w500,
                          color: isActive
                              ? const Color(0xFF2563EB)
                              : Colors.black87,
                        ),
                      ),
                      trailing: isActive
                          ? const Icon(Icons.check_rounded,
                          color: Color(0xFF2563EB))
                          : null,
                      onTap: () {
                        onSelect(o);
                        Navigator.pop(context);
                      },
                    );
                  }),

                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

// ============================================================
// FILTER SHEET
// ============================================================
Future<void> showFilterSheet({
  required BuildContext context,
  required String selectedFilter,
  required Color Function(String) rarityColor,
  required Function(String) onSelect,
}) {
  final options = ["All", "Default", "Common", "Rare", "Epic", "Legendary"];

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
    ),
    builder: (_) {
      return SafeArea(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.65,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Column(
                children: [
                  Container(
                    height: 5,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),

                  const SizedBox(height: 14),
                  const Text(
                    "Filter by rarity",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Show only the outfits with the rarity you want.",
                    style: TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                  const SizedBox(height: 10),

                  ...options.map((o) {
                    final bool isActive = selectedFilter == o;
                    final Color dot =
                    o == "All" ? Colors.black45 : rarityColor(o);

                    return ListTile(
                      leading: Icon(Icons.circle, color: dot),
                      title: Text(
                        o == "All" ? "All rarities" : o,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight:
                          isActive ? FontWeight.w700 : FontWeight.w500,
                          color: isActive ? dot : Colors.black87,
                        ),
                      ),
                      trailing:
                      isActive ? Icon(Icons.check_rounded, color: dot) : null,
                      onTap: () {
                        onSelect(o);
                        Navigator.pop(context);
                      },
                    );
                  }),

                  const Divider(height: 20),

                  ListTile(
                    leading: const Icon(Icons.close_rounded, color: Colors.red),
                    title: const Text(
                      "Clear filter",
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    onTap: () {
                      onSelect("All");
                      Navigator.pop(context);
                    },
                  ),

                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

// ============================================================
// COINS SHEET
// ============================================================
Future<void> showCoinsSheet({
  required BuildContext context,
  required int coins,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
    ),
    builder: (_) {
      return SafeArea(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.55,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
              child: Column(
                children: [
                  Container(
                    height: 5,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),

                  const SizedBox(height: 14),
                  const Text(
                    "Bondie Coins",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Earn coins by completing challenges, answering check-ins\n"
                        "and taking care of your relationship every day.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13, color: Colors.black54),
                  ),

                  const SizedBox(height: 16),

                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F3F3),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.monetization_on_rounded,
                            size: 22, color: Colors.amber[700]),
                        const SizedBox(width: 8),
                        Text(
                          coins.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 14),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

// ============================================================
// NOT ENOUGH COINS SHEET
// ============================================================
Future<void> showNotEnoughCoinsSheet({
  required BuildContext context,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
    ),
    builder: (_) {
      return SafeArea(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.55,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 14),
                  const Icon(Icons.close_outlined,
                      size: 45, color: Color(0xFFF30D0D)),
                  const SizedBox(height: 10),

                  const Text(
                    "Not enough Bondie Coins",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),

                  const SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 27),
                    child: const Text(
                      "Keep completing challenges, check-ins and moments together to unlock new skins.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13, color: Colors.black54),
                    ),
                  ),


                  const SizedBox(height: 18),

                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2563EB),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: const Text(
                        "Got it",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

// ============================================================
// CONFIRM BUY SHEET
// ============================================================
Future<void> showConfirmBuySheet({
  required BuildContext context,
  required String skinName,
  required String skinAsset,
  required int price,
  required VoidCallback onConfirm,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
    ),
    builder: (_) {
      return SafeArea(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.60,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
              child: Column(
                children: [
                  Container(
                    height: 5,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    "Confirm Purchase",
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "Are you sure you want to unlock this Bondie outfit?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                  ),

                  const SizedBox(height: 18),

                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F3F3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          skinAsset,
                          height: 85,
                        ),
                        const SizedBox(width: 16),
                        Flexible(
                          child: Text(
                            skinName,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.monetization_on_rounded,
                        size: 22,
                        color: Colors.amber[700],
                      ),
                      const SizedBox(width: 6),
                      Text(
                        price.toString(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 22),

                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      onConfirm();
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3B82F6),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Center(
                        child: Text(
                          "Confirm Purchase",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 11),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Center(
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            fontSize: 14.5,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
