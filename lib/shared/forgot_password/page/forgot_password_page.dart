import 'package:certify/shared/components/text_field_certify.dart';
import 'package:certify/shared/theme/app_colors.dart';
import 'package:certify/shared/theme/app_fonts.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  final TextEditingController _controllerUsername = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          style: const ButtonStyle(
            iconColor: MaterialStatePropertyAll(
              AppColors.fontSecondary,
            ),
          ),
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: AppColors.backgroundSecondary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Esqueci minha senha",
                  style: TextStyle(color: AppColors.fontSecondary, fontSize: 24, fontFamily: AppFonts.robotoCondensed),
                ),
                const SizedBox(height: 24),
                TextFieldCertify(
                  "Usuário",
                  "Informe seu email",
                  _controllerUsername,
                  secondaryColor: true,
                ),
                const SizedBox(height: 24),
                FilledButton(
                  style: const ButtonStyle(
                    foregroundColor: MaterialStatePropertyAll(AppColors.fontPrimary),
                    backgroundColor: MaterialStatePropertyAll(AppColors.backgroundPrimary),
                    padding: MaterialStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    ),
                    textStyle: MaterialStatePropertyAll(
                      TextStyle(fontSize: 14, fontWeight: FontWeight.bold, fontFamily: AppFonts.robotoCondensed),
                    ),
                    minimumSize: MaterialStatePropertyAll(
                      Size(252, 24),
                    ),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        margin: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                        showCloseIcon: true,
                        closeIconColor: AppColors.snackBarCloseIcon,
                        backgroundColor: AppColors.snackBarBackground,
                        behavior: SnackBarBehavior.floating,
                        content: Text(
                          textAlign: TextAlign.start,
                          style: TextStyle(color: AppColors.fontPrimary),
                          'Verifique seu email!',
                        ),
                        duration: Duration(milliseconds: 10000),
                      ),
                    );
                    Navigator.pop(context);
                  },
                  child: const Text('Recuperar senha'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SnackBarExample extends StatelessWidget {
  const SnackBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('Show Snackbar'),
      onPressed: () {},
    );
  }
}
