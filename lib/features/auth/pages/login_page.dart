import 'package:flutter/material.dart';
import 'package:veterinaria_app/features/auth/auth_validators.dart';
import 'package:veterinaria_app/features/auth/pages/register_page.dart';
import 'package:veterinaria_app/features/auth/widgets/auth_button.dart';
import 'package:veterinaria_app/features/auth/widgets/auth_page_shell.dart';
import 'package:veterinaria_app/features/auth/widgets/auth_text_field.dart';
import 'package:veterinaria_app/features/cliente/pages/home_cliente_page.dart';

class PaginaLogin extends StatefulWidget {
  const PaginaLogin({super.key});

  @override
  State<PaginaLogin> createState() => _EstadoPaginaLogin();
}

class _EstadoPaginaLogin extends State<PaginaLogin> {
  final _claveFormulario = GlobalKey<FormState>();
  final _controladorEmail = TextEditingController();
  final _controladorContrasena = TextEditingController();

  bool _ocultarContrasena = true;
  AutovalidateMode _modoAutovalidacion = AutovalidateMode.disabled;

  @override
  void dispose() {
    _controladorEmail.dispose();
    _controladorContrasena.dispose();
    super.dispose();
  }

  void _enviarFormulario() {
    _controladorEmail.text = _controladorEmail.text.trim();

    if (!_claveFormulario.currentState!.validate()) {
      setState(() {
        _modoAutovalidacion = AutovalidateMode.onUserInteraction;
      });
      return;
    }

    // Punto de reemplazo futuro: iniciar sesión contra MockAPI.
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (context) => const PaginaHomeCliente()),
    );
  }

  void _abrirRegistro() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (context) => const PaginaRegistro()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final temaTexto = Theme.of(context).textTheme;

    return ContenedorPaginaAutenticacion(
      titulo: 'Bienvenido de nuevo',
      subtitulo: 'Ingresá tus datos para acceder a tu cuenta.',
      formulario: Form(
        key: _claveFormulario,
        autovalidateMode: _modoAutovalidacion,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.password],
              alAlternarVisibilidad: () {
                setState(() => _ocultarContrasena = !_ocultarContrasena);
              },
              onFieldSubmitted: (_) => _enviarFormulario(),
              validator: ValidadoresAutenticacion.validarContrasena,
            ),
            TextButton(
              onPressed: () {
                // La recuperación de contraseña se implementará más adelante.
              },
              style: TextButton.styleFrom(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(vertical: 8),
                visualDensity: VisualDensity.compact,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                '¿Olvidaste tu contraseña?',
                textAlign: TextAlign.end,
              ),
            ),
            const SizedBox(height: 8),
            BotonAutenticacion(
              etiqueta: 'Ingresar',
              onPressed: _enviarFormulario,
            ),
          ],
        ),
      ),
      pie: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text('¿No tenés cuenta? ', style: temaTexto.bodyMedium),
          TextButton(
            onPressed: _abrirRegistro,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text('Crear cuenta'),
          ),
        ],
      ),
    );
  }
}
