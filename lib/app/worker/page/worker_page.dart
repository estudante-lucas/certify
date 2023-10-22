import 'package:certify/app/components/certificate_card.dart';
import 'package:certify/shared/models/worker/worker_model.dart';
import 'package:certify/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class WorkerPage extends StatelessWidget {
  const WorkerPage({super.key});

  @override
  Widget build(BuildContext context) {
    var user = ModalRoute.of(context)!.settings.arguments as Worker;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundSecondary,
        leading: IconButton(
          style: const ButtonStyle(
            iconColor: MaterialStatePropertyAll(
              AppColors.fontSecondary,
            ),
          ),
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(user.name),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 8),
              const Text("Treinamentos Ativos"),
              const SizedBox(height: 16),
              CertificateCard("Técnico em irrigação", DateTime.utc(2023, DateTime.october, 25)),
              CertificateCard("Técnico em irrigação", DateTime.utc(2023, DateTime.december, 25)),
              CertificateCard("Técnico em irrigação", DateTime.utc(2023, DateTime.september, 25)),
            ],
          ),
        ),
      ),
    );
  }
}
