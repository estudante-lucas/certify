import 'package:certify/app/home/page/home_page.dart';
import 'package:certify/app/worker/page/worker_page.dart';
import 'package:certify/config/firebase/firebase_options.dart';
import 'package:certify/shared/components/text_field_certify.dart';
import 'package:certify/shared/forgot_password/page/forgot_password_page.dart';
import 'package:certify/shared/icons/app_logo.dart';
import 'package:certify/shared/routes/app_routes.dart';
import 'package:certify/shared/services/auth/auth_service.dart';
import 'package:certify/shared/theme/app_colors.dart';
import 'package:certify/shared/theme/app_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const LoginPage(),
      routes: {
        AppRoutes.forgotPassword: (BuildContext context) {
          return ForgotPasswordPage();
        },
        AppRoutes.dashboard: (BuildContext context) {
          return const HomePage();
        },
        AppRoutes.worker: (BuildContext context) {
          return const WorkerPage();
        },
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                TextFieldCertify("Usuário", "Informe seu email", _controllerUsername),
                const SizedBox(height: 16),
                TextFieldCertify(
                  "Senha",
                  "Informe sua senha",
                  _controllerPassword,
                  obscureText: true,
                ),
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
                        Navigator.pushNamed(context, AppRoutes.dashboard);
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
