import 'package:certify/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  const DashboardCard(
    this.title,
    this.onTap, {
    super.key,
  });

  final String title;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.black.withAlpha(30),
        ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      color: AppColors.cardBackground,
      child: SizedBox(
        width: 160,
        height: 160,
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          splashColor: AppColors.cardBackground.withAlpha(30),
          onTap: onTap,
          child: ListTile(
            mouseCursor: SystemMouseCursors.click,
            title: Center(child: Text(title)),
          ),
        ),
      ),
    );
  }
}
