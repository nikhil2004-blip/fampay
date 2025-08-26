import 'package:flutter/material.dart';
import '../../../data/repository/card_repository.dart';
import '../../../data/services/api_service.dart';   // ✅ important
import '../../../state/home_provider.dart';
import '../widgets/card_factory.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  late final HomeProvider _homeProvider;

  @override
  void initState() {
    super.initState();
    _homeProvider = HomeProvider(
      repository: CardRepository(
        apiService: ApiService(),   // ✅ pass apiService here
      ),
    );
    _homeProvider.fetchCards();   // ✅ fixed name
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Feed")),
      body: AnimatedBuilder(
        animation: _homeProvider,
        builder: (context, _) {
          if (_homeProvider.state == HomeState.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (_homeProvider.state == HomeState.error) {
            return Center(
              child: Text("Error: ${_homeProvider.errorMessage}"),
            );
          }

          if (_homeProvider.cardGroups.isEmpty) {
            return const Center(child: Text("No cards available"));
          }

          return ListView.builder(
            itemCount: _homeProvider.cardGroups.length,
            itemBuilder: (context, index) {
              final group = _homeProvider.cardGroups[index];
              return CardFactory.buildCardGroup(group, _homeProvider);
            },
          );
        },
      ),
    );
  }
}
