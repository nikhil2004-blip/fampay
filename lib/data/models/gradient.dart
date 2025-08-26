class GradientModel {
  final List<String> colors;
  final double angle;

  GradientModel({required this.colors, required this.angle});

  factory GradientModel.fromJson(Map<String, dynamic> json) {
    return GradientModel(
      colors: (json['colors'] as List<dynamic>?)
          ?.map((c) => c as String)
          .toList() ??
          [],
      angle: (json['angle'] != null) ? (json['angle'] as num).toDouble() : 0,
    );
  }
}
