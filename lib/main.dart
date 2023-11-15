import 'package:certify/app/home/page/home_page.dart';
import 'package:certify/config/firebase/firebase_options.dart';
import 'package:certify/shared/login/login_page.dart';
import 'package:certify/shared/routes/map_routes.dart';
import 'package:certify/shared/services/auth/auth_service.dart';
import 'package:certify/web/dashboard/page/dashboard_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
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
      home: const AuthenticationWrapper(),
      routes: Routes.all,
      navigatorObservers: [RouteObserver<PageRoute>()],
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    if (AuthService.isAuthenticated()) {
      if (kIsWeb) {
        return const DashboardPage();
      } else {
        return const HomePage();
      }
    } else {
      return const LoginPage();
    }
  }
}
