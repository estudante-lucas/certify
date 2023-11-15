import 'package:certify/shared/models/training/training_model.dart';
import 'package:certify/shared/routes/web_routes.dart';
import 'package:certify/shared/services/training/training_service.dart';
import 'package:certify/web/training/form_training.dart';
import 'package:flutter/material.dart';

class NewTrainingPage extends StatelessWidget {
  const NewTrainingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FormTraining(
        title: "Novo treinamento",
        onSave: (name, description) {
          Training training = Training(name, description);

          TrainingService.add(training).then((value) {
            Navigator.popAndPushNamed(context, WebRoutes.trainings);
          }).onError((error, stackTrace) {
            const snackBar = SnackBar(
              content: Text('Ocorreu um erro ao adicionar um treinamento!'),
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          });
        });
  }
}
