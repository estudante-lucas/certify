import 'package:certify/shared/components/text_field/text_field_certify.dart';
import 'package:certify/shared/icons/app_logo.dart';
import 'package:certify/shared/routes/app_routes.dart';
import 'package:certify/shared/routes/web_routes.dart';
import 'package:certify/shared/services/auth/auth_service.dart';
import 'package:certify/shared/theme/app_colors.dart';
import 'package:certify/shared/theme/app_fonts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  void navigateHome(BuildContext context) {
    if (kIsWeb) {
      Navigator.pushNamed(context, WebRoutes.dashboard);
    } else {
      Navigator.pushNamed(context, AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (AuthService.isAuthenticated()) {
      navigateHome(context);
    }

    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        toolbarHeight: 0,
      ),
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppLogo.logo(size: 30),
                const Text(
                  "Certify",
                  style: TextStyle(
                    color: AppColors.fontPrimary,
                    fontFamily: AppFonts.poetsenOne,
                    fontSize: 64.0,
                  ),
                ),
                const SizedBox(height: 24),
                TextFieldCertify("Usuário", "Informe seu email", _controllerUsername, TextInputType.emailAddress),
                const SizedBox(height: 16),
                TextFieldCertify("Senha", "Informe sua senha", _controllerPassword, TextInputType.visiblePassword, obscureText: true),
                const SizedBox(height: 24),
                FilledButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(AppColors.fontPrimary),
                    padding: MaterialStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    ),
                    textStyle: MaterialStatePropertyAll(
                      TextStyle(fontSize: 14),
                    ),
                    minimumSize: MaterialStatePropertyAll(
                      Size(252, 24),
                    ),
                  ),
                  onPressed: () {
                    AuthService.authenticate(_controllerUsername.text, _controllerPassword.text).then((userCredential) {
                      if (userCredential != null) {
                        navigateHome(context);
                      } else {
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
                              'Email ou senha incorreto!',
                            ),
                            duration: Duration(milliseconds: 10000),
                          ),
                        );
                      }
                    });
                  },
                  child: const Text('Entrar'),
                ),
                const SizedBox(height: 8),
                TextButton(
                  style: const ButtonStyle(
                    foregroundColor: MaterialStatePropertyAll(
                      AppColors.fontPrimary,
                    ),
                    overlayColor: MaterialStatePropertyAll(
                      AppColors.overlayPrimary,
                    ),
                    padding: MaterialStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    ),
                    textStyle: MaterialStatePropertyAll(
                      TextStyle(fontSize: 14),
                    ),
                    minimumSize: MaterialStatePropertyAll(
                      Size(252, 24),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.forgotPassword);
                  },
                  child: const Text("Esqueci minha senha"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
