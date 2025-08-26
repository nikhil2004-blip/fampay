import 'package:flutter/material.dart';
import '../../data/models/card_group.dart';
import '../../data/models/card.dart';

class HC9DynamicWidthCard extends StatelessWidget {
  final CardGroup group;

  const HC9DynamicWidthCard({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isLandscape = size.width > size.height;

    final double height = isLandscape
        ? size.height * 0.6
        : size.height * 0.35;

    return SizedBox(
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: group.cards.length,
        itemBuilder: (context, index) {
          return _buildCard(group.cards[index], height, context);
        },
      ),
    );
  }

  Widget _buildCard(CardModel card, double height, BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (card.url != null) {
          debugPrint("Tapped on HC9: ${card.url}");
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        width: _calculateDynamicWidth(height, context),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: _buildGradientFromAPI(card),
          image: card.bgImage?.imageUrl != null
              ? DecorationImage(
            image: NetworkImage(card.bgImage!.imageUrl!),
            fit: BoxFit.cover,
          )
              : null,
        ),
        child: card.title != null && card.title!.trim().isNotEmpty
            ? Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              card.title!,
              style: TextStyle(
                fontSize: height * 0.08,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: const [
                  Shadow(
                    color: Colors.black54,
                    blurRadius: 4,
                    offset: Offset(1, 1),
                  )
                ],
              ),
            ),
          ),
        )
            : null,
      ),
    );
  }

  double _calculateDynamicWidth(double height, BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isLandscape = size.width > size.height;

    if (isLandscape) {
      return size.width * 0.65;
    } else {
      return height * 0.75;
    }
  }

  /// 🔑 Build gradient from API if available
  LinearGradient _buildGradientFromAPI(CardModel card) {
    if (card.bgGradient != null && card.bgGradient!.colors.isNotEmpty) {
      // Convert hex colors from API to Color objects
      final colors = card.bgGradient!.colors
          .map((hex) => Color(int.parse(hex.replaceFirst("#", "0xff"))))
          .toList();
      return LinearGradient(
        colors: colors,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else {
      // Fallback gradient
      return const LinearGradient(
        colors: [Colors.grey, Colors.black45],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }
  }
}
