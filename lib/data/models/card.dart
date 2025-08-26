import 'cta.dart';
import 'entity.dart';
import 'gradient.dart';
import 'card_image.dart';

class CardModel {
  final String name;
  final String? title;
  final String? description;
  final FormattedText? formattedTitle;
  final FormattedText? formattedDescription;
  final CardImage? icon;
  final CardImage? bgImage;
  final String? bgColor;
  final GradientModel? bgGradient;
  final String? url;
  final List<Cta> ctas;

  CardModel({
    required this.name,
    this.title,
    this.description,
    this.formattedTitle,
    this.formattedDescription,
    this.icon,
    this.bgImage,
    this.bgColor,
    this.bgGradient,
    this.url,
    required this.ctas,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      name: json['name'] ?? '',
      title: json['title'],
      description: json['description'],
      formattedTitle: json['formatted_title'] != null
          ? FormattedText.fromJson(json['formatted_title'])
          : null,
      formattedDescription: json['formatted_description'] != null
          ? FormattedText.fromJson(json['formatted_description'])
          : null,
      icon: json['icon'] != null ? CardImage.fromJson(json['icon']) : null,
      bgImage: json['bg_image'] != null ? CardImage.fromJson(json['bg_image']) : null,
      bgColor: json['bg_color'],
      bgGradient:
      json['bg_gradient'] != null ? GradientModel.fromJson(json['bg_gradient']) : null,
      url: json['url'],
      ctas: (json['cta'] as List<dynamic>?)
          ?.map((c) => Cta.fromJson(c))
          .toList() ??
          [],
    );
  }
}

class FormattedText {
  final String text;
  final List<Entity> entities;

  FormattedText({required this.text, required this.entities});

  factory FormattedText.fromJson(Map<String, dynamic> json) {
    return FormattedText(
      text: json['text'] ?? '',
      entities: (json['entities'] as List<dynamic>?)
          ?.map((e) => Entity.fromJson(e))
          .toList() ??
          [],
    );
  }
}
