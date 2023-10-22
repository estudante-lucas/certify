import 'package:certify/app/components/recent_cards.dart';
import 'package:certify/shared/components/search_bar/search_suggestion_bar.dart';
import 'package:certify/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundSecondary,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
        centerTitle: true,
        title: const Text(
          "Consultar Treinamentos",
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.account_circle),
          )
        ],
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            children: [
              SearchSuggestionBar(),
              SizedBox(height: 24),
              Column(
                children: [
                  Text("Recentes"),
                  SizedBox(height: 12),
                  RecentCards(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
