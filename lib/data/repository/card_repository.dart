import '../models/card_group.dart';
import '../services/api_service.dart';

class CardRepository {
  final ApiService apiService;

  CardRepository({required this.apiService});

  Future<List<CardGroup>> getCardGroups() async {
    return await apiService.fetchCardGroups();
  }
}
