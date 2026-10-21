import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ServicioAutenticacion {
  const ServicioAutenticacion._();

  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static User? get usuarioActual => _auth.currentUser;

  static Future<void> iniciarSesion({
    required String email,
    required String contrasena,
  }) async {
    await _auth.signInWithEmailAndPassword(email: email, password: contrasena);
  }

  static Future<void> registrar({
    required String nombre,
    required String email,
    required String contrasena,
  }) async {
    final credencial = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: contrasena,
    );
    final usuario = credencial.user!;
    await usuario.updateDisplayName(nombre);
    await _db.collection('usuarios').doc(usuario.uid).set({
      'nombre': nombre,
      'email': email,
      'rol': 'veterinario',
      'creadoEn': FieldValue.serverTimestamp(),
    });
  }

  static Future<void> recuperarContrasena(String email) =>
      _auth.sendPasswordResetEmail(email: email);

  static Future<void> cerrarSesion() => _auth.signOut();

  static String mensajeDeError(Object error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'invalid-email':
          return 'El email no es válido';
        case 'user-disabled':
          return 'Esta cuenta está deshabilitada';
        case 'user-not-found':
        case 'wrong-password':
        case 'invalid-credential':
          return 'Email o contraseña incorrectos';
        case 'email-already-in-use':
          return 'Ya existe una cuenta con ese email';
        case 'weak-password':
          return 'La contraseña es muy débil (mínimo 6 caracteres)';
        case 'too-many-requests':
          return 'Demasiados intentos. Probá de nuevo en unos minutos';
        case 'network-request-failed':
          return 'Sin conexión a internet';
      }
    }
    return 'Ocurrió un error. Intentá de nuevo';
  }
}