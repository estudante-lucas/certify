import 'package:certify/app/components/certificate_card.dart';
import 'package:certify/shared/models/collaborator/collaborator_model.dart';
import 'package:certify/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class WorkerPage extends StatelessWidget {
  const WorkerPage({super.key});

  @override
  Widget build(BuildContext context) {
    var user = ModalRoute.of(context)!.settings.arguments as Collaborator;

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
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 8),
              const Text("Treinamentos"),
              const SizedBox(height: 16),
              Column(
                children: (user.collaboratorTrainings != null && user.collaboratorTrainings!.isNotEmpty)
                    ? user.collaboratorTrainings!
                        .map((collaboratorTraining) => CertificateCard(collaboratorTraining.training.name, collaboratorTraining.deadline))
                        .toList()
                    : [const Text("Nenhum treinamento cadastrado!")],
              )
            ],
          ),
        ),
      ),
    );
  }
}
