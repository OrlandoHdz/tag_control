import 'package:flutter/material.dart';
import 'package:tag_control/theme/app_theme.dart';

import 'features/auth/presentation/screens/buscar_screen.dart';
import 'features/auth/presentation/screens/consultar_screen.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'features/auth/presentation/screens/register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme().getTheme(),
      home: const LoginScreen(),
      routes: {
        '/registar':(context) => const RegisterScreen(),
        '/buscar':(context) => const BuscarScreen(),
        '/consultar': (context) => const ConsultarScreen(),
        '/login':(context) => const LoginScreen()
      },
    );
  }
}