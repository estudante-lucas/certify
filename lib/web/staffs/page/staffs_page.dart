import 'package:certify/shared/components/snapshot_data/snapshot_data.dart';
import 'package:certify/shared/components/table_data/table_data.dart';
import 'package:certify/shared/models/staff/staff_model.dart';
import 'package:certify/shared/routes/web_routes.dart';
import 'package:certify/shared/services/staff/staff_service.dart';
import 'package:certify/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class StaffsPage extends StatelessWidget {
  const StaffsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<List<Staff>?> futureStaffs = StaffService.findAll();

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
          "Técnicos",
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
                future: futureStaffs,
                builder: (context, snapshot) {
                  return SnapshotData(
                    snapshot: snapshot,
                    data: (data) {
                      return TableData(
                          onAdd: () => Navigator.pushNamed(context, WebRoutes.newStaff),
                          headers: const [
                            "Nome",
                            "Função",
                            "Cidade - Estado",
                            "Ações",
                          ],
                          rows: data!
                              .map((staff) => [
                                    Text(staff.name),
                                    Text(staff.cpf),
                                    Text(staff.phone),
                                    OutlinedButton(
                                      onPressed: () {
                                        StaffService.delete(staff.id!).then((value) {
                                          Navigator.popAndPushNamed(context, WebRoutes.staffs);
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
                          const Text('Não existem técnicos cadastrados!'),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, WebRoutes.newStaff);
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
