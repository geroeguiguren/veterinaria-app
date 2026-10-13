import 'package:flutter/material.dart';
import 'package:veterinaria_app/app/theme/app_theme.dart';

class MarcaVeterinaria extends StatelessWidget {
  const MarcaVeterinaria({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: ColoresAplicacion.principal,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: ColoresAplicacion.principal.withValues(alpha: 0.28),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Icon(Icons.pets, color: Colors.white, size: 28),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              'Veterinaria',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
      ],
    );
  }
}
