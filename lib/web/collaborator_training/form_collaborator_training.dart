import 'package:certify/shared/components/date_picker/date_picker.dart';
import 'package:certify/shared/models/collaborator/collaborator_training.dart';
import 'package:certify/shared/models/training/training_model.dart';
import 'package:certify/shared/services/training/training_service.dart';
import 'package:certify/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class FormCollaboratorTraining extends StatefulWidget {
  const FormCollaboratorTraining({required this.title, required this.onSave, super.key});

  final String title;
  final void Function(CollaboratorTraining collaboratorTraining) onSave;

  @override
  FormCollaboratorTrainingState createState() => FormCollaboratorTrainingState();
}

class FormCollaboratorTrainingState extends State<FormCollaboratorTraining> {
  final _formKey = GlobalKey<FormState>();

  List<Training>? _trainings = [];
  Training? _selectedTraining = Training("", "");
  DateTime? _deadline = DateTime.now();

  bool _saveButtonVisible = false;

  @override
  void initState() {
    super.initState();

    TrainingService.findAll().then((value) {
      setState(() {
        _saveButtonVisible = true;
        _trainings = value;
        _selectedTraining = value?.first;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundSecondary,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        centerTitle: true,
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.account_circle),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              DropdownButtonFormField(
                value: _selectedTraining,
                items: _trainings?.map((Training value) {
                  return DropdownMenuItem<Training>(
                    value: value,
                    child: Text(value.name),
                  );
                }).toList(),
                onChanged: (Training? newValue) {
                  if (newValue == null) return;
                  setState(() {
                    _selectedTraining = newValue;
                  });
                },
              ),
              const SizedBox(height: 20.0),
              DatePicker(restorationId: 'main', (date) => setState(() => _deadline = date)),
              const SizedBox(height: 20.0),
              _saveButtonVisible
                  ? ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          CollaboratorTraining collaboratorTraining = CollaboratorTraining(_selectedTraining!, _deadline!);
                          widget.onSave(collaboratorTraining);
                        }
                      },
                      child: const Text('Salvar'),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
