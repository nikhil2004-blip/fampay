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

  String _appTitle = "Loading...";
  String get appTitle => _appTitle;

  String? _appIconUrl;
  String? get appIconUrl => _appIconUrl;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  final Set<String> _dismissedCards = {};
  final Set<String> _remindLaterCards = {};

  Future<void> fetchCards() async {
    _state = HomeState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await repository.getCardGroups();

      // ✅ Set AppBar title from top-level feedSlug
      _appTitle = repository.apiService.feedSlug;
      // Optional: icon from first card of first group
      if (result.isNotEmpty && result[0].cards.isNotEmpty) {
        _appIconUrl = result[0].cards[0].icon?.imageUrl;
      }

      // Filter out dismissed/remindLater cards
      _cardGroups = result.map((group) {
        group.cards.removeWhere(
              (card) =>
          _dismissedCards.contains(card.name) ||
              _remindLaterCards.contains(card.name),
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

  void dismissCard(String cardName) {
    _dismissedCards.add(cardName);
    _removeCardFromGroups(cardName);
  }

  void remindLater(String cardName) {
    _remindLaterCards.add(cardName);
    _removeCardFromGroups(cardName);
  }

  void resetRemindLater() {
    _remindLaterCards.clear();
  }

  void _removeCardFromGroups(String cardName) {
    _cardGroups = _cardGroups.map((group) {
      group.cards.removeWhere((card) => card.name == cardName);
      return group;
    }).toList();
    notifyListeners();
  }
}
