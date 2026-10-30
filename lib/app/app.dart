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
      home: const _PantallaInicial(),
    );
  }
}

/// Decide la primera pantalla: login, o el home si hay una sesión de
/// veterinario válida (el rol se verifica contra Firestore).
class _PantallaInicial extends StatelessWidget {
  const _PantallaInicial();

  @override
  Widget build(BuildContext context) {
    if (ServicioAutenticacion.usuarioActual == null) {
      return const PaginaLogin();
    }
    return FutureBuilder<bool>(
      future: ServicioAutenticacion.sesionEsVeterinario(),
      builder: (context, estado) {
        if (estado.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return estado.data == true
            ? const PaginaHomeAdmin()
            : const PaginaLogin();
      },
    );
  }
}
