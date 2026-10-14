import 'package:flutter/material.dart';
import 'package:veterinaria_app/features/cliente/data/datos_ejemplo.dart';
import 'package:veterinaria_app/features/cliente/models/mascota.dart';
import 'package:veterinaria_app/features/cliente/pages/alta_mascota_page.dart';
import 'package:veterinaria_app/features/cliente/widgets/tarjeta_mascota.dart';

class PaginaMisMascotas extends StatefulWidget {
  const PaginaMisMascotas({super.key});

  @override
  State<PaginaMisMascotas> createState() => _EstadoPaginaMisMascotas();
}

class _EstadoPaginaMisMascotas extends State<PaginaMisMascotas> {
  final List<Mascota> _mascotas = List.of(mascotasEjemplo);

  Future<void> _abrirAltaMascota() async {
    final nueva = await Navigator.of(context).push<Mascota>(
      MaterialPageRoute<Mascota>(
        builder: (context) => const PaginaAltaMascota(),
      ),
    );

    if (nueva == null) {
      return;
    }

    // Punto de reemplazo futuro: guardar la mascota en MockAPI.
    setState(() => _mascotas.add(nueva));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Mascotas'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _abrirAltaMascota,
        tooltip: 'Agregar mascota',
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 88),
              itemCount: _mascotas.length,
              separatorBuilder: (context, indice) => const SizedBox(height: 12),
              itemBuilder: (context, indice) {
                return TarjetaMascota(mascota: _mascotas[indice]);
              },
            ),
          ),
        ),
      ),
    );
  }
}
