import 'package:flutter/material.dart';
import 'package:veterinaria_app/app/theme/app_theme.dart';
import 'package:veterinaria_app/features/models/turno.dart';


class TarjetaTurno extends StatelessWidget {
  const TarjetaTurno({super.key, required this.turno, this.onTap});

  final Turno turno;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context).textTheme;

    return Material(
      color: ColoresAplicacion.secundarioSuave,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(turno.hora, style: tema.bodyMedium),
              const SizedBox(height: 4),
              Text(
                '${turno.mascota} - Cliente: ${turno.duenio}',
                style: tema.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w700,
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