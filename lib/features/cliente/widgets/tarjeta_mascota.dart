import 'package:flutter/material.dart';
import 'package:veterinaria_app/app/theme/app_theme.dart';
import 'package:veterinaria_app/features/cliente/models/mascota.dart';

class TarjetaMascota extends StatelessWidget {
  const TarjetaMascota({super.key, required this.mascota});

  final Mascota mascota;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context).textTheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: ColoresAplicacion.superficie,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColoresAplicacion.borde),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const CircleAvatar(
              backgroundColor: ColoresAplicacion.secundarioSuave,
              child: Icon(Icons.pets, color: ColoresAplicacion.principal),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mascota.nombre,
                    style: tema.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: ColoresAplicacion.textoPrincipal,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${mascota.especie} · ${mascota.raza} · ${mascota.edad} años',
                    style: tema.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
