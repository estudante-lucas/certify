import 'package:certify/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppLogo {
  static Widget logo({size = 40}) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(
          Icons.shield,
          size: size * 3.0,
          color: AppColors.iconPrimary,
        ),
        Icon(
          Icons.circle,
          size: size * 1.5,
          color: AppColors.iconSecondary,
        ),
        Icon(
          Icons.star,
          size: size * 1.0,
          color: AppColors.iconPrimary,
        ),
      ],
    );
  }
}
