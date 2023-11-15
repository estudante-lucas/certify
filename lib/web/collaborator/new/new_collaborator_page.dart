import 'package:certify/shared/models/collaborator/collaborator_model.dart';
import 'package:certify/shared/routes/web_routes.dart';
import 'package:certify/shared/services/collaborator/collaborator_service.dart';
import 'package:certify/web/collaborator/form_collaborator.dart';
import 'package:flutter/material.dart';

class NewCollaboratorPage extends StatelessWidget {
  const NewCollaboratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FormCollaborator(
        title: "Novo colaborador",
        onSave: (name, registrationNumber, role, cpf, email, phone) {
          Collaborator collaborator = Collaborator(name, registrationNumber, role, cpf, email, phone);

          CollaboratorService.add(collaborator).then((value) {
            Navigator.popAndPushNamed(context, WebRoutes.collaborators);
          }).onError((error, stackTrace) {
            const snackBar = SnackBar(
              content: Text('Ocorreu um erro ao adicionar um colaborador!'),
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          });
        });
  }
}
