import 'package:flutter/material.dart';
import 'package:veterinaria_app/app/theme/app_theme.dart';

/// Botón cuadrado con ícono y texto para los accesos de la pantalla de inicio.
class BotonAccesoRapido extends StatelessWidget {
  const BotonAccesoRapido({
    super.key,
    required this.etiqueta,
    required this.icono,
    required this.onPressed,
  });

  final String etiqueta;
  final IconData icono;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColoresAplicacion.secundarioSuave,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icono, color: ColoresAplicacion.principal, size: 28),
              const SizedBox(height: 8),
              Text(
                etiqueta,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: ColoresAplicacion.textoPrincipal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
