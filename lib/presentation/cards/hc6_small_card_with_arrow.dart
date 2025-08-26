import 'package:flutter/material.dart';
import '../../data/models/card_group.dart';
import '../../data/models/card.dart';

class HC6SmallCardWithArrow extends StatelessWidget {
  final CardGroup group;

  const HC6SmallCardWithArrow({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    return group.isScrollable
        ? SizedBox(
      height: 88, // height for scrollable horizontal list
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: group.cards.length,
        itemBuilder: (context, index) {
          return _buildCard(group.cards[index], context);
        },
      ),
    )
        : Column(
      children: group.cards
          .map((card) => _buildCard(card, context))
          .toList(),
    );
  }

  Widget _buildCard(CardModel card, BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (card.url != null) {
          debugPrint("Tapped on ${card.url}");
        }
      },
      child: Container(
        height: 72, // fixed card height like in Figma
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Left Icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(8),
              ),
              child: card.icon?.imageUrl != null
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  card.icon!.imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.person, color: Colors.white),
                ),
              )
                  : const Icon(Icons.person, color: Colors.white),
            ),
            const SizedBox(width: 16),

            // Title Text
            Expanded(
              child: Text(
                card.title ?? "Small card with arrow",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),

            // Right Arrow
            const Icon(Icons.arrow_forward_ios,
                size: 18, color: Colors.black54),
          ],
        ),
      ),
    );
  }
}
