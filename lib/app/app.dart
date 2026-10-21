import 'package:flutter/material.dart';
import 'package:veterinaria_app/app/theme/app_theme.dart';
import 'package:veterinaria_app/features/admin/pages/home_admin_page.dart';
import 'package:veterinaria_app/features/auth/pages/login_page.dart';
import 'package:veterinaria_app/features/auth/servicio_autenticacion.dart';

class AplicacionVeterinaria extends StatelessWidget {
  const AplicacionVeterinaria({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Veterinaria',
      debugShowCheckedModeBanner: false,
      theme: TemaAplicacion.claro,
      home: ServicioAutenticacion.usuarioActual == null
          ? const PaginaLogin()
          : const PaginaHomeAdmin(),
    );
  }
}