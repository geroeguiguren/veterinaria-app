import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:veterinaria_app/features/models/paciente.dart';

/// Pacientes = mascotas que los clientes registran en la colección
/// `mascotas` de Firestore. Las reglas permiten que solo los veterinarios
/// lean todas las mascotas.
class RepositorioPacientes {
  const RepositorioPacientes._();

  static Stream<List<Paciente>> pacientes() {
    return FirebaseFirestore.instance
        .collection('mascotas')
        .snapshots()
        .map((consulta) {
      final pacientes = [
        for (final documento in consulta.docs)
          Paciente.desdeMapa(documento.id, documento.data()),
      ];
      pacientes.sort(
        (a, b) => a.nombre.toLowerCase().compareTo(b.nombre.toLowerCase()),
      );
      return pacientes;
    });
  }
}
