import 'package:certify/shared/components/snapshot_data/snapshot_data.dart';
import 'package:certify/shared/components/table_data/table_data.dart';
import 'package:certify/shared/models/collaborator/collaborator_model.dart';
import 'package:certify/shared/routes/web_routes.dart';
import 'package:certify/shared/services/collaborator/collaborator_service.dart';
import 'package:certify/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CollaboratorTrainingsPage extends StatelessWidget {
  const CollaboratorTrainingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var collaborator = ModalRoute.of(context)!.settings.arguments as Collaborator;
    var futureCollaboratorTrainings = Future.value(collaborator.collaboratorTrainings);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundSecondary,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName(WebRoutes.dashboard));
            }),
        centerTitle: true,
        title: Text(
          'Treinamentos de ${collaborator.name}',
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
                future: futureCollaboratorTrainings,
                builder: (context, snapshot) {
                  return SnapshotData(
                    snapshot: snapshot,
                    data: (data) {
                      return TableData(
                          onAdd: () => Navigator.pushNamed(context, WebRoutes.newCollaboratorTraining, arguments: collaborator),
                          headers: const [
                            "Nome",
                            "Descrição",
                            "Validade",
                            "Ações",
                          ],
                          rows: data!
                              .map((collaboratorTraining) => [
                                    Text(collaboratorTraining.training.name),
                                    Text(collaboratorTraining.training.description),
                                    Text(
                                        '${collaboratorTraining.deadline.day}/${collaboratorTraining.deadline.month}/${collaboratorTraining.deadline.year}'),
                                    OutlinedButton(
                                      onPressed: () {
                                        collaborator.collaboratorTrainings?.remove(collaboratorTraining);

                                        CollaboratorService.update(collaborator).then((value) {
                                          Navigator.popAndPushNamed(context, WebRoutes.collaboratorTrainings, arguments: collaborator);
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
                          Text('${collaborator.name} não possui treinamentos!'),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, WebRoutes.newCollaboratorTraining, arguments: collaborator);
                            },
                            child: const Text('Clique aqui para adicionar.'),
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
