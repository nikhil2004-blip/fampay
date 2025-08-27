import 'package:flutter/material.dart';
import '../../data/models/card_group.dart';
import '../../data/models/card.dart';

class HC1SmallDisplayCard extends StatelessWidget {
  final CardGroup group;

  const HC1SmallDisplayCard({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLandscape = size.width > size.height;

    final double cardHeight =
    isLandscape ? size.height * 0.25 : size.height * 0.18;

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: _buildCard(
        group.cards.isNotEmpty ? group.cards.first : null,
        context,
        size.width,
        cardHeight,
      ),
    );
  }

  Widget _buildCard(
      CardModel? card, BuildContext context, double width, double height) {
    if (card == null) return const SizedBox.shrink();

    // Use API text exactly: first line = formatted_title, second line = formatted_description
    String firstLine = card.formattedTitle?.entities.isNotEmpty == true
        ? card.formattedTitle!.entities[0].text ?? ""
        : "";
    String secondLine = card.formattedDescription?.entities.isNotEmpty == true
        ? card.formattedDescription!.entities[0].text ?? ""
        : "";

    return GestureDetector(
      onTap: () {
        if (card.url != null) debugPrint("Tapped on ${card.url}");
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: card.bgColor != null
              ? Color(int.parse(card.bgColor!.replaceFirst("#", "0xff")))
              : Colors.indigo,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 👤 Icon/Avatar
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: CircleAvatar(
                radius: height * 0.3,
                backgroundImage: card.icon?.imageUrl != null
                    ? NetworkImage(card.icon!.imageUrl!)
                    : null,
                backgroundColor: Colors.blueAccent,
                child: card.icon?.imageUrl == null
                    ? Icon(Icons.person, size: height * 0.3, color: Colors.white)
                    : null,
              ),
            ),

            // 📑 Texts from API
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      firstLine,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: height * 0.14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: height * 0.05),
                    Text(
                      secondLine,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: height * 0.12,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
