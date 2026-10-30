import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:veterinaria_app/features/data/datos_ejemplo.dart';
import 'package:veterinaria_app/features/models/turno.dart';

/// Turnos del veterinario con sesión iniciada (colección `turnos`).
///
/// [escuchar] mantiene actualizado `turnosAgenda` en tiempo real: cuando un
/// cliente reserva o cancela, la agenda cambia sola.
class RepositorioTurnos {
  const RepositorioTurnos._();

  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _suscripcion;
  static String? _uidEscuchado;

  /// Empieza a escuchar los turnos reservados del veterinario actual.
  static void escuchar() {
    final usuario = FirebaseAuth.instance.currentUser;
    if (usuario == null) return;
    if (_suscripcion != null && _uidEscuchado == usuario.uid) return;

    _suscripcion?.cancel();
    _uidEscuchado = usuario.uid;
    _suscripcion = _db
        .collection('turnos')
        .where('veterinarioUid', isEqualTo: usuario.uid)
        .snapshots()
        .listen(
      (consulta) {
        turnosAgenda.value = [
          for (final documento in consulta.docs)
            if (documento.data()['estado'] == 'reservado')
              Turno.desdeMapa(documento.id, documento.data()),
        ];
      },
      onError: (Object _) => turnosAgenda.value = const <Turno>[],
    );
  }

  /// Deja de escuchar y vacía la agenda (se usa al cerrar sesión).
  static Future<void> detener() async {
    await _suscripcion?.cancel();
    _suscripcion = null;
    _uidEscuchado = null;
    turnosAgenda.value = const <Turno>[];
  }

  /// Cancela el turno y libera el horario (en una sola operación).
  static Future<void> cancelar(Turno turno) async {
    final usuario = FirebaseAuth.instance.currentUser!;
    final lote = _db.batch();
    lote.update(_db.collection('turnos').doc(turno.id), {
      'estado': 'cancelado',
      'canceladoPor': 'veterinario',
      'canceladoEn': FieldValue.serverTimestamp(),
    });
    lote.delete(_db.collection('ocupados').doc('${usuario.uid}_${turno.clave}'));
    await lote.commit();
  }
}
