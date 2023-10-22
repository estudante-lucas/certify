import 'package:certify/shared/models/worker/worker_model.dart';
import 'package:certify/shared/routes/app_routes.dart';
import 'package:certify/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class RecentCard extends StatelessWidget {
  const RecentCard({
    super.key,
    required this.user,
  });

  final Worker user;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(12.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(30),
            blurRadius: 3.0,
          ),
        ],
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.black.withAlpha(30),
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        color: AppColors.cardBackground,
        child: InkWell(
          splashColor: AppColors.cardBackground.withAlpha(30),
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.worker, arguments: user);
          },
          child: ListTile(
            leading: Stack(
              alignment: Alignment.center,
              children: [
                const Icon(Icons.circle, size: 45, color: AppColors.backgroundSecondary),
                user.image != null
                    ? Text("IM")
                    : Text(
                        user.getInitials(),
                        style: TextStyle(color: AppColors.fontSecondary),
                      )
              ],
            ),
            title: Text(user.name),
            subtitle: Text(user.role),
          ),
        ),
      ),
    );
  }
}
