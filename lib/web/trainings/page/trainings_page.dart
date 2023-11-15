import 'package:certify/shared/components/snapshot_data/snapshot_data.dart';
import 'package:certify/shared/components/table_data/table_data.dart';
import 'package:certify/shared/models/training/training_model.dart';
import 'package:certify/shared/routes/web_routes.dart';
import 'package:certify/shared/services/training/training_service.dart';
import 'package:certify/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class TrainingsPage extends StatelessWidget {
  const TrainingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<List<Training>?> futureTrainings = TrainingService.findAll();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundSecondary,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName(WebRoutes.dashboard));
            }),
        centerTitle: true,
        title: const Text(
          "Treinamentos",
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
          child: Center(
            child: FutureBuilder(
                future: futureTrainings,
                builder: (context, snapshot) {
                  return SnapshotData(
                    snapshot: snapshot,
                    data: (data) {
                      return TableData(
                          onAdd: () => Navigator.popAndPushNamed(context, WebRoutes.newTraining),
                          headers: const [
                            "Nome",
                            "Descrição",
                            "Ações",
                          ],
                          rows: data!
                              .map((training) => [
                                    Text(training.name),
                                    Text(training.description),
                                    OutlinedButton(
                                      onPressed: () {
                                        TrainingService.delete(training.id!).then((value) {
                                          Navigator.popAndPushNamed(context, WebRoutes.trainings);
                                        });
                                      },
                                      child: const Text(
                                        "Remover",
                                        style: TextStyle(color: AppColors.error),
                                      ),
                                    )
                                  ])
                              .toList());
                    },
                    noData: Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Não existem treinamentos cadastrados!'),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, WebRoutes.newTraining);
                            },
                            child: const Text('Clique aqui para cadastrar.'),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
