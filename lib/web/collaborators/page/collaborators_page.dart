import 'package:certify/shared/components/snapshot_data/snapshot_data.dart';
import 'package:certify/shared/components/table_data/table_data.dart';
import 'package:certify/shared/models/collaborator/collaborator_model.dart';
import 'package:certify/shared/routes/web_routes.dart';
import 'package:certify/shared/services/collaborator/collaborator_service.dart';
import 'package:certify/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CollaboratorsPage extends StatelessWidget {
  const CollaboratorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<List<Collaborator>?> futureCollaborators = CollaboratorService.findAll();

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
          "Colaboradores",
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
                future: futureCollaborators,
                builder: (context, snapshot) {
                  return SnapshotData(
                    snapshot: snapshot,
                    data: (data) {
                      return TableData(
                          onAdd: () => Navigator.pushNamed(context, WebRoutes.newCollaborator),
                          headers: const [
                            "Nome",
                            "Função",
                            "Email",
                            "Ações",
                          ],
                          rows: data!
                              .map((collaborator) => [
                                    Text(collaborator.name),
                                    Text(collaborator.role),
                                    Text(collaborator.email),
                                    Row(
                                      children: [
                                        OutlinedButton(
                                          onPressed: () {
                                            Navigator.pushNamed(context, WebRoutes.collaboratorTrainings, arguments: collaborator);
                                          },
                                          child: const Text(
                                            "Treinamentos",
                                            style: TextStyle(color: AppColors.error),
                                          ),
                                        ),
                                        OutlinedButton(
                                          onPressed: () {
                                            CollaboratorService.delete(collaborator.id!).then((value) {
                                              Navigator.popAndPushNamed(context, WebRoutes.collaborators);
                                            });
                                          },
                                          child: const Text(
                                            "Remover",
                                            style: TextStyle(color: AppColors.error),
                                          ),
                                        ),
                                      ],
                                    )
                                  ])
                              .toList());
                    },
                    noData: Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Não existem colaboradores cadastrados!'),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, WebRoutes.newCollaborator);
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
