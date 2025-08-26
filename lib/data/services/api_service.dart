import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/card_group.dart';

class ApiService {
  static const String baseUrl =
      "https://polyjuice.kong.fampay.co/mock/famapp/feed/home_section/?slugs=famx-paypage";

  Future<List<CardGroup>> fetchCardGroups() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // ✅ Root is a List → take first element → hc_groups
        final groups = data[0]["hc_groups"] as List<dynamic>;

        List<CardGroup> cardGroups =
        groups.map((json) => CardGroup.fromJson(json)).toList();

        return cardGroups;
      } else {
        throw Exception("Failed to load cards: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching cards: $e");
    }
  }
}
