import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/card_group.dart';

class ApiService {
  static const String baseUrl =
      "https://polyjuice.kong.fampay.co/mock/famapp/feed/home_section/?slugs=famx-paypage";

  String feedSlug = "famx-paypage"; //  AppBar title from top-level feed
  String? appIconUrl; // Optional icon

  Future<List<CardGroup>> fetchCardGroups() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // ✅ Extract top-level slug for AppBar
        feedSlug = data[0]["slug"] ?? "famx-paypage";

        // Extract hc_groups
        final groups = data[0]["hc_groups"] as List<dynamic>;
        List<CardGroup> cardGroups =
        groups.map((json) => CardGroup.fromJson(json)).toList();

        // Optional: set appIconUrl from first card if available
        if (groups.isNotEmpty &&
            groups[0]["cards"] != null &&
            groups[0]["cards"].isNotEmpty) {
          final firstCard = groups[0]["cards"][0];
          if (firstCard["icon"] != null &&
              firstCard["icon"]["image_url"] != null) {
            appIconUrl = firstCard["icon"]["image_url"];
          }
        }

        return cardGroups;
      } else {
        throw Exception("Failed to load cards: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching cards: $e");
    }
  }
}
