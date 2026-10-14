import 'package:flutter/material.dart';
import 'package:veterinaria_app/app/theme/app_theme.dart';
import 'package:veterinaria_app/features/auth/pages/login_page.dart';
// import 'package:veterinaria_app/features/client_dashboard/pages/home_page.dart';

class AplicacionVeterinaria extends StatelessWidget {
  const AplicacionVeterinaria({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Veterinaria',
      debugShowCheckedModeBanner: false,
      theme: TemaAplicacion.claro,
      home: const PaginaLogin(),
  //  home: const HomePage(),
    );
  }
}
