import 'package:flutter/material.dart';
import '../../data/models/card_group.dart';
import '../../data/models/card.dart';
import '../../state/home_provider.dart';

class HC3BigDisplayCard extends StatelessWidget {
  final CardGroup group;
  final HomeProvider? provider;

  const HC3BigDisplayCard({
    super.key,
    required this.group,
    this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: group.cards.map((card) {
        return _BigCardItem(
          card: card,
          provider: provider,
        );
      }).toList(),
    );
  }
}

class _BigCardItem extends StatefulWidget {
  final CardModel card;
  final HomeProvider? provider;

  const _BigCardItem({required this.card, this.provider});

  @override
  State<_BigCardItem> createState() => _BigCardItemState();
}

class _BigCardItemState extends State<_BigCardItem> {
  bool _showActions = false;
  static const double _actionsPanelWidth = 90.0;

  void _toggleActions() {
    if (widget.provider != null) {
      setState(() {
        _showActions = !_showActions;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final card = widget.card;
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth - 32; // 16px margin on each side

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: GestureDetector(
        onTap: () {
          if (_showActions) {
            _toggleActions();
            return;
          }
          if (card.url != null) debugPrint("Tapped ${card.url}");
        },
        onLongPress: _toggleActions,
        child: SizedBox(
          height: 300, // ⬅️ Increased height
          width: cardWidth,
          child: Stack(
            children: [
              if (widget.provider != null && _showActions)
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: _ActionsPanel(
                    width: _actionsPanelWidth,
                    card: card,
                    provider: widget.provider!,
                  ),
                ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                left: _showActions ? _actionsPanelWidth : 0,
                right: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: card.bgColor != null
                        ? Color(int.parse(card.bgColor!.replaceFirst("#", "0xff")))
                        : const Color(0xFF4C63D2),
                    borderRadius: BorderRadius.circular(16),
                    image: card.bgImage?.imageUrl != null
                        ? DecorationImage(
                      image: NetworkImage(card.bgImage!.imageUrl!),
                      fit: BoxFit.cover,
                    )
                        : null,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Icon (Responsive)
                            Align(
                              alignment: Alignment.topRight,
                              child: card.icon?.imageUrl != null
                                  ? Container(
                                width: constraints.maxWidth * 0.18,
                                height: constraints.maxWidth * 0.18,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    card.icon!.imageUrl!,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: Colors.grey[300],
                                        child: const Icon(Icons.image, color: Colors.grey),
                                      );
                                    },
                                  ),
                                ),
                              )
                                  : const SizedBox.shrink(),
                            ),

                            const SizedBox(height: 16),

                            // Title Section
                            if (card.title != null) ...[
                              Text(
                                "Big display card",
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: const Color(0xFFFFB800),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 28,
                                  height: 1.2,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "with action",
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24,
                                  height: 1.2,
                                ),
                              ),
                            ],

                            const Spacer(),

                            // Subtitle
                            Text(
                              "This is a sample text for the subtitle that you can add to contextual cards",
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 12,
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 16),

                            // CTA Button
                            if (card.ctas != null && card.ctas!.isNotEmpty)
                              Container(
                                constraints: const BoxConstraints(minWidth: 100),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: card.ctas![0].bgColor != null
                                        ? Color(int.parse(card.ctas![0].bgColor!.replaceFirst("#", "0xff")))
                                        : Colors.black,
                                    foregroundColor: card.ctas![0].textColor != null
                                        ? Color(int.parse(card.ctas![0].textColor!.replaceFirst("#", "0xff")))
                                        : Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                    elevation: 0,
                                  ),
                                  onPressed: () => debugPrint("CTA tapped: ${card.ctas![0].url}"),
                                  child: Text(
                                    card.ctas![0].text ?? "Action",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionsPanel extends StatelessWidget {
  final double width;
  final CardModel card;
  final HomeProvider provider;

  const _ActionsPanel({
    required this.width,
    required this.card,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          bottomLeft: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(2, 0),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _ActionButton(
            label: "Remind\nLater",
            icon: Icons.schedule_rounded,
            color: const Color(0xFFFFB338),
            onTap: () => provider.remindLater(card.name),
          ),
          const SizedBox(height: 20),
          _ActionButton(
            label: "Dismiss\nNow",
            icon: Icons.close_rounded,
            color: const Color(0xFFF25656),
            onTap: () => provider.dismissCard(card.name),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 70,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 10,
                fontWeight: FontWeight.w500,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
