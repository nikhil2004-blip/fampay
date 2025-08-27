import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/services/api_service.dart';
import 'data/repository/card_repository.dart';
import 'state/home_provider.dart';
import 'presentation/screens/home_screen.dart';

void main() {
  final repository = CardRepository(apiService: ApiService());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeProvider(repository: repository)..fetchCards(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 👇 Dynamically get title from HomeProvider
    final appTitle = context.select<HomeProvider, String>(
          (provider) => provider.appTitle,
    );

    return MaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: false,// dynamically from API
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
