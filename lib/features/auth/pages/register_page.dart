import 'package:flutter/material.dart';
import 'package:veterinaria_app/features/auth/auth_validators.dart';
import 'package:veterinaria_app/features/auth/widgets/auth_button.dart';
import 'package:veterinaria_app/features/auth/widgets/auth_page_shell.dart';
import 'package:veterinaria_app/features/auth/widgets/auth_text_field.dart';

class PaginaRegistro extends StatefulWidget {
  const PaginaRegistro({super.key});

  @override
  State<PaginaRegistro> createState() => _EstadoPaginaRegistro();
}

class _EstadoPaginaRegistro extends State<PaginaRegistro> {
  final _claveFormulario = GlobalKey<FormState>();
  final _controladorNombre = TextEditingController();
  final _controladorEmail = TextEditingController();
  final _controladorContrasena = TextEditingController();
  final _controladorConfirmarContrasena = TextEditingController();

  bool _ocultarContrasena = true;
  bool _ocultarConfirmarContrasena = true;
  AutovalidateMode _modoAutovalidacion = AutovalidateMode.disabled;

  @override
  void dispose() {
    _controladorNombre.dispose();
    _controladorEmail.dispose();
    _controladorContrasena.dispose();
    _controladorConfirmarContrasena.dispose();
    super.dispose();
  }

  void _enviarFormulario() {
    _controladorNombre.text = _controladorNombre.text.trim();
    _controladorEmail.text = _controladorEmail.text.trim();

    if (!_claveFormulario.currentState!.validate()) {
      setState(() {
        _modoAutovalidacion = AutovalidateMode.onUserInteraction;
      });
      return;
    }

    // Punto de reemplazo futuro: crear el usuario en MockAPI.
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(content: Text('Cuenta creada correctamente')),
      );
  }

  void _volverAlLogin() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final temaTexto = Theme.of(context).textTheme;

    return ContenedorPaginaAutenticacion(
      titulo: 'Crear cuenta',
      subtitulo: 'Completá tus datos para registrarte.',
      formulario: Form(
        key: _claveFormulario,
        autovalidateMode: _modoAutovalidacion,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CampoAutenticacion(
              controller: _controladorNombre,
              etiqueta: 'Nombre',
              icono: Icons.person_outline,
              textCapitalization: TextCapitalization.words,
              autofillHints: const [AutofillHints.name],
              validator: ValidadoresAutenticacion.validarNombre,
            ),
            const SizedBox(height: 16),
            CampoAutenticacion(
              controller: _controladorEmail,
              etiqueta: 'Email',
              icono: Icons.mail_outline,
              keyboardType: TextInputType.emailAddress,
              autofillHints: const [AutofillHints.email],
              validator: ValidadoresAutenticacion.validarEmail,
            ),
            const SizedBox(height: 16),
            CampoAutenticacion(
              controller: _controladorContrasena,
              etiqueta: 'Contraseña',
              icono: Icons.lock_outline,
              obscureText: _ocultarContrasena,
              autofillHints: const [AutofillHints.newPassword],
              alAlternarVisibilidad: () {
                setState(() => _ocultarContrasena = !_ocultarContrasena);
              },
              validator: ValidadoresAutenticacion.validarContrasena,
            ),
            const SizedBox(height: 16),
            CampoAutenticacion(
              controller: _controladorConfirmarContrasena,
              etiqueta: 'Confirmar contraseña',
              icono: Icons.lock_outline,
              obscureText: _ocultarConfirmarContrasena,
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.newPassword],
              alAlternarVisibilidad: () {
                setState(
                  () => _ocultarConfirmarContrasena =
                      !_ocultarConfirmarContrasena,
                );
              },
              onFieldSubmitted: (_) => _enviarFormulario(),
              validator: (valor) =>
                  ValidadoresAutenticacion.validarConfirmarContrasena(
                    valor,
                    _controladorContrasena.text,
                  ),
            ),
            const SizedBox(height: 24),
            BotonAutenticacion(
              etiqueta: 'Registrarme',
              onPressed: _enviarFormulario,
            ),
          ],
        ),
      ),
      pie: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text('¿Ya tenés cuenta? ', style: temaTexto.bodyMedium),
          TextButton(
            onPressed: _volverAlLogin,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text('Iniciar sesión'),
          ),
        ],
      ),
    );
  }
}
