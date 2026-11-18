class HorarioAtencion {
  const HorarioAtencion({
    required this.activo,
    required this.desde,
    required this.hasta,
  });

  final bool activo;
  final String desde;
  final String hasta;

  factory HorarioAtencion.desdeMapa(Map<String, dynamic> datos) {
    return HorarioAtencion(
      activo: datos['activo'] == true,
      desde: (datos['desde'] as String?) ?? '09:00',
      hasta: (datos['hasta'] as String?) ?? '18:00',
    );
  }

   Map<String, dynamic> aMapa() => {
      'activo':activo, 'desde':desde, 'hasta':hasta
    };
  }
}
