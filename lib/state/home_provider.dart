import 'package:flutter/material.dart';
import '../data/models/card_group.dart';
import '../data/repository/card_repository.dart';

enum HomeState { idle, loading, error, loaded }

class HomeProvider extends ChangeNotifier {
  final CardRepository repository;

  HomeProvider({required this.repository});

  HomeState _state = HomeState.idle;
  HomeState get state => _state;

  List<CardGroup> _cardGroups = [];
  List<CardGroup> get cardGroups => List.unmodifiable(_cardGroups);

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  /// To keep track of dismissed cards (for HC3 handling)
  final Set<String> _dismissedCards = {};
  final Set<String> _remindLaterCards = {};

  /// Fetch cards from repository
  Future<void> fetchCards() async {
    _state = HomeState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await repository.getCardGroups();

      // Filter out dismissed and remindLater cards
      _cardGroups = result.map((group) {
        group.cards.removeWhere(
              (card) => _dismissedCards.contains(card.name) || _remindLaterCards.contains(card.name),
        );
        return group;
      }).toList();

      _state = HomeState.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _state = HomeState.error;
    }

    notifyListeners();
  }

  /// Permanently remove a card
  void dismissCard(String cardName) {
    _dismissedCards.add(cardName);
    _removeCardFromGroups(cardName);
  }

  /// Temporarily remove a card (will reappear on next fetch)
  void remindLater(String cardName) {
    _remindLaterCards.add(cardName);
    _removeCardFromGroups(cardName);
  }

  /// Reset remindLater cards when app restarts
  void resetRemindLater() {
    _remindLaterCards.clear();
  }

  /// Internal helper: removes a card from all groups
  void _removeCardFromGroups(String cardName) {
    _cardGroups = _cardGroups.map((group) {
      group.cards.removeWhere((card) => card.name == cardName);
      return group;
    }).toList();
    notifyListeners();
  }
}
