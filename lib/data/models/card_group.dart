import 'card.dart';

class CardGroup {
  final int id;
  final String name;
  final String designType;
  final List<CardModel> cards;
  final bool isScrollable;
  final int? height;
  final bool isFullWidth;
  final String? slug;
  final int? level;

  CardGroup({
    required this.id,
    required this.name,
    required this.designType,
    required this.cards,
    this.isScrollable = false,
    this.height,
    this.isFullWidth = false,
    this.slug,
    this.level,
  });

  factory CardGroup.fromJson(Map<String, dynamic> json) {
    return CardGroup(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      designType: json['design_type'] ?? '',
      cards: (json['cards'] as List<dynamic>)
          .map((c) => CardModel.fromJson(c))
          .toList(),
      isScrollable: json['is_scrollable'] ?? false,
      height: json['height'],
      isFullWidth: json['is_full_width'] ?? false,
      slug: json['slug'],
      level: json['level'],
    );
  }
}
