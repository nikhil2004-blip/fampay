class Cta {
  final String text;
  final String? bgColor;
  final String? textColor;
  final String? url;

  Cta({
    required this.text,
    this.bgColor,
    this.textColor,
    this.url,
  });

  factory Cta.fromJson(Map<String, dynamic> json) {
    return Cta(
      text: json['text'] ?? '',
      bgColor: json['bg_color'],
      textColor: json['text_color'],
      url: json['url'],
    );
  }
}
