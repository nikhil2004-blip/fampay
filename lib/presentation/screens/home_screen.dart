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
        title: const Text("Contextual Cards"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await provider.fetchCards();
        },
        child: Builder(
          builder: (_) {
            // 🔹 Handle loading state
            if (provider.state == HomeState.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            // 🔹 Handle error state
            if (provider.state == HomeState.error) {
              return Center(
                child: Text(
                  provider.errorMessage ?? "Something went wrong",
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            // 🔹 Handle loaded state
            if (provider.state == HomeState.loaded) {
              if (provider.cardGroups == null || provider.cardGroups!.isEmpty) {
                return const Center(child: Text("No cards available"));
              }

              return ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: provider.cardGroups!.length,
                itemBuilder: (context, index) {
                  final group = provider.cardGroups![index];
                  return CardFactory.buildCardGroup(group, provider);
                },
              );
            }

            // 🔹 Fallback for any unexpected state
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
