import 'package:flutter/material.dart';
import '../../data/models/card_group.dart';
import '../../data/models/card.dart';

class HC5ImageCard extends StatelessWidget {
  final CardGroup group;

  const HC5ImageCard({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9, // keeps same proportions across devices
      child: group.isScrollable
          ? ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: group.cards.length,
        itemBuilder: (context, index) {
          return _buildCard(group.cards[index], context);
        },
      )
          : Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: group.cards
            .map((card) => Expanded(child: _buildCard(card, context)))
            .toList(),
      ),
    );
  }

  Widget _buildCard(CardModel card, BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (card.url != null) {
          debugPrint("Tapped on HC5: ${card.url}");
        }
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background image
              if (card.bgImage?.imageUrl != null)
                Image.network(
                  card.bgImage!.imageUrl!,
                  fit: BoxFit.contain, // ensures image fits in box, no crop
                ),

              // Text overlay
              if (card.title != null)
                LayoutBuilder(
                  builder: (context, constraints) {
                    double fontSize = constraints.maxWidth * 0.06; // responsive
                    return Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          card.title!,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fontSize,
                            fontWeight: FontWeight.bold,
                            shadows: const [
                              Shadow(
                                color: Colors.black54,
                                blurRadius: 4,
                                offset: Offset(1, 1),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
