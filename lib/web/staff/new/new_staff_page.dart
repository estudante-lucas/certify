import 'package:certify/shared/models/staff/staff_model.dart';
import 'package:certify/shared/routes/web_routes.dart';
import 'package:certify/shared/services/staff/staff_service.dart';
import 'package:certify/web/staff/form_staff.dart';
import 'package:flutter/material.dart';

class NewStaffPage extends StatelessWidget {
  const NewStaffPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FormStaff(
        title: "Novo técnico",
        onSave: (name, role, cpf, email, phone) {
          Staff staff = Staff(name, role, cpf, email, phone);

          StaffService.add(staff).then((value) {
            Navigator.popAndPushNamed(context, WebRoutes.staffs);
          }).onError((error, stackTrace) {
            const snackBar = SnackBar(
              content: Text('Ocorreu um erro ao adicionar um técnico!'),
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          });
        });
  }
}
