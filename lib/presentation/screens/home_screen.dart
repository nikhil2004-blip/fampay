import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../state/home_provider.dart';
import '../cards/card_factory.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ✅ Show icon if available
            if (provider.appIconUrl != null)
              Image.network(
                provider.appIconUrl!,
                width: 32,
                height: 32,
                errorBuilder: (_, __, ___) => const Icon(Icons.apps),
              ),
            if (provider.appIconUrl != null) const SizedBox(width: 8),
            // ✅ Show dynamic title
            Text(
              provider.appTitle,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await provider.fetchCards();
        },
        child: Builder(
          builder: (_) {
            // 🔹 Loading state
            if (provider.state == HomeState.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            // 🔹 Error state
            if (provider.state == HomeState.error) {
              return Center(
                child: Text(
                  provider.errorMessage ?? "Something went wrong",
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            // 🔹 Loaded state
            if (provider.state == HomeState.loaded) {
              if (provider.cardGroups.isEmpty) {
                return const Center(child: Text("No cards available"));
              }

              return ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: provider.cardGroups.length,
                itemBuilder: (context, index) {
                  final group = provider.cardGroups[index];
                  return CardFactory.buildCardGroup(group, provider);
                },
              );
            }

            // 🔹 Fallback
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
