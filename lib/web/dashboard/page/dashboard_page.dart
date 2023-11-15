import 'package:certify/shared/routes/web_routes.dart';
import 'package:certify/shared/theme/app_colors.dart';
import 'package:certify/web/components/dashboard_card.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
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
          "Dashboard",
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.account_circle),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DashboardCard("Técnicos", () {
                Navigator.pushNamed(context, WebRoutes.staffs);
              }),
              const SizedBox(width: 24),
              DashboardCard("Colaboradores", () {
                Navigator.pushNamed(context, WebRoutes.collaborators);
              }),
              const SizedBox(width: 24),
              DashboardCard("Treinamentos", () {
                Navigator.pushNamed(context, WebRoutes.trainings);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
