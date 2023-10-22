import 'dart:math' as math;

import 'package:certify/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class CertificateCard extends StatelessWidget {
  const CertificateCard(this.title, this.validAt, {super.key});

  final String title;
  final DateTime validAt;

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('pt_BR', null);

    const successIcon = Icon(
      Icons.check_circle,
      color: AppColors.success,
    );

    const warningIcon = Icon(
      Icons.warning,
      color: AppColors.warning,
    );

    var errorIcon = Transform.rotate(
        angle: math.pi / 4,
        child: const Icon(
          Icons.add_circle,
          color: AppColors.error,
        ));

    Widget icon;
    Color backgroundColor;

    if (validAt.isBefore(DateTime.now())) {
      icon = errorIcon;
      backgroundColor = AppColors.errorBackground;
    } else if (validAt.isBefore(DateTime.now().add(const Duration(days: 30)))) {
      icon = warningIcon;
      backgroundColor = AppColors.warningBackground;
    } else {
      icon = successIcon;
      backgroundColor = AppColors.successBackground;
    }

    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.black.withAlpha(30),
            ),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          color: backgroundColor,
          child: ListTile(
            leading: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.newspaper),
              ],
            ),
            title: Text(title, style: const TextStyle(color: AppColors.fontOnSurface)),
            subtitle: Text(DateFormat.yMd('pt_BR').format(validAt), style: const TextStyle(color: AppColors.fontOnSurface)),
            trailing: icon,
          ),
        ),
        const SizedBox(height: 8)
      ],
    );
  }
}
