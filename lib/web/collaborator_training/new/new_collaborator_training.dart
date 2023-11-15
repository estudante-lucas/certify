import 'package:certify/shared/models/collaborator/collaborator_model.dart';
import 'package:certify/shared/routes/web_routes.dart';
import 'package:certify/shared/services/collaborator/collaborator_service.dart';
import 'package:certify/web/collaborator_training/form_collaborator_training.dart';
import 'package:flutter/material.dart';

class NewCollaboratorTrainingPage extends StatelessWidget {
  const NewCollaboratorTrainingPage({super.key});

  @override
  Widget build(BuildContext context) {
    var collaborator = ModalRoute.of(context)!.settings.arguments as Collaborator;

    return FormCollaboratorTraining(
        title: "Incluir treinamento para ${collaborator.name}",
        onSave: (collaboratorTraining) {
          collaborator.collaboratorTrainings ??= [];
          collaborator.collaboratorTrainings!.add(collaboratorTraining);

          CollaboratorService.update(collaborator).then((value) {
            Navigator.popAndPushNamed(context, WebRoutes.collaboratorTrainings, arguments: collaborator);
          }).onError((error, stackTrace) {
            const snackBar = SnackBar(
              content: Text('Ocorreu um erro ao adicionar um treinamento!'),
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          });
        });
  }
}
