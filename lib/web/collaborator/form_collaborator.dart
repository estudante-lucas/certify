import 'package:certify/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class FormCollaborator extends StatefulWidget {
  const FormCollaborator({
    required this.title,
    required this.onSave,
    Key? key,
  }) : super(key: key);

  final String title;
  final void Function(String name, String registrationNumber, String role, String cpf, String email, String phone) onSave;

  @override
  FormCollaboratorState createState() => FormCollaboratorState();
}

class FormCollaboratorState extends State<FormCollaborator> {
  final _formKey = GlobalKey<FormState>();

  String _selectedRole = 'Selecione uma função';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _registrationNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final MaskTextInputFormatter _cpfFormatter = MaskTextInputFormatter(mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')});
  final MaskTextInputFormatter _phoneFormatter = MaskTextInputFormatter(mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')});

  final List<String> _roles = [
    'Selecione uma função',
    'Administrador',
    'Auxiliar',
    'Coordenador',
    'Diretor',
    'Gerente',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundSecondary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
                  labelText: 'Nome',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Digite um nome válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              DropdownButtonFormField<String>(
                value: _selectedRole,
                items: _roles.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue == null) return;
                  setState(() {
                    _selectedRole = newValue;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Função',
                ),
                validator: (value) {
                  if (value == 'Selecione uma função') {
                    return 'Selecione uma função válida';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _registrationNumberController,
                decoration: const InputDecoration(
                  labelText: 'Matrícula',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Digite o número da matrícula';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _cpfController,
                decoration: const InputDecoration(
                  labelText: 'CPF',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [_cpfFormatter],
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 11) {
                    return 'Digite um CPF válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'Digite um email válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Telefone',
                ),
                inputFormatters: [_phoneFormatter],
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 11) {
                    return 'Digite um telefone válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.onSave(
                      _nameController.text,
                      _registrationNumberController.text,
                      _selectedRole,
                      _cpfController.text,
                      _emailController.text,
                      _phoneController.text,
                    );
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
