class HorarioAtencion {
  const HorarioAtencion({
    required this.activo,
    required this.desde,
    required this.hasta,
  });

  final bool activo;
  final String desde;
  final String hasta;

  //dart trata a las funciones mas como first class citizens respecto a java
  // /q recuerdo q solo permitia arrow functions
  //para lo de implementación de metodos definidos en  interfaces funcionales
  //borrar esto antes de mostrarseloal profe!
  //ver q mas puedo simplificar tmb pasando de imperativo a declarativo, para q sea mas legible el código, cuidando lo del nullsafety
  //xq los documentos de firebase admiten dynamic q es nullable y dart tiene lo del sound null safety x lo q eel compilador
  //me obliga a laburarlos para pasar de errores a tiempo de ejecución a correcciones en tiempo de compilación, x  lo q vi hasta ahora sino es imposible
  //tener un npe
  factory HorarioAtencion.desdeMapa(Map<String, dynamic> datos) => HorarioAtencion(
      activo: datos['activo'] == true,
      desde: (datos['desde'] as String?) ?? '09:00',
      hasta: (datos['hasta'] as String?) ?? '18:00',
    );

   Map<String, dynamic> aMapa() => {
      'activo':activo, 'desde':desde, 'hasta':hasta
    };

    
  }

