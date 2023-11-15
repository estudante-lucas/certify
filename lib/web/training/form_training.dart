import 'package:certify/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class FormTraining extends StatefulWidget {
  const FormTraining({required this.title, required this.onSave, super.key});

  final String title;
  final void Function(String name, String description) onSave;

  @override
  FormTrainingState createState() => FormTrainingState();
}

class FormTrainingState extends State<FormTraining> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

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
              TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(color: AppColors.fontPrimary),
                    labelText: 'Nome',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Digite um nome válido';
                    }
                    return null;
                  }),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelStyle: TextStyle(color: AppColors.fontPrimary),
                  labelText: 'Descrição',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Digite uma descrição válida';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.onSave(_nameController.text, _descriptionController.text);
                  }
                },
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
