import 'package:flutter/material.dart';
import 'package:veterinaria_app/app/theme/app_theme.dart';
import 'package:veterinaria_app/features/auth/widgets/auth_brand.dart';

/// Estructura común de Login y Registro.
///
/// El scroll y la altura mínima evitan overflow cuando aparece el teclado.
class ContenedorPaginaAutenticacion extends StatelessWidget {
  const ContenedorPaginaAutenticacion({
    super.key,
    required this.titulo,
    required this.subtitulo,
    required this.formulario,
    required this.pie,
  });

  final String titulo;
  final String subtitulo;
  final Widget formulario;
  final Widget pie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const _FondoSuave(),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return _ContenidoDesplazableAutenticacion(
                  alturaVisible: constraints.maxHeight,
                  titulo: titulo,
                  subtitulo: subtitulo,
                  formulario: formulario,
                  pie: pie,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ContenidoDesplazableAutenticacion extends StatelessWidget {
  const _ContenidoDesplazableAutenticacion({
    required this.alturaVisible,
    required this.titulo,
    required this.subtitulo,
    required this.formulario,
    required this.pie,
  });

  final double alturaVisible;
  final String titulo;
  final String subtitulo;
  final Widget formulario;
  final Widget pie;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    const rellenoVertical = 32.0;
    final alturaDisponible = alturaVisible - rellenoVertical;

    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 440,
            minHeight: alturaDisponible < 0 ? 0 : alturaDisponible,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 12),
                  const MarcaVeterinaria(),
                  const SizedBox(height: 28),
                  Text(titulo, style: tema.textTheme.headlineMedium),
                  const SizedBox(height: 8),
                  Text(subtitulo, style: tema.textTheme.bodyLarge),
                  const SizedBox(height: 24),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: ColoresAplicacion.superficie,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: ColoresAplicacion.textoPrincipal.withValues(
                            alpha: 0.06,
                          ),
                          blurRadius: 24,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 22, 20, 20),
                      child: formulario,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 8),
                child: pie,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FondoSuave extends StatelessWidget {
  const _FondoSuave();

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        Positioned(
          top: -90,
          right: -50,
          child: _Mancha(tamano: 220, opacidad: 0.14),
        ),
        Positioned(
          bottom: -120,
          left: -70,
          child: _Mancha(tamano: 260, opacidad: 0.08),
        ),
      ],
    );
  }
}

class _Mancha extends StatelessWidget {
  const _Mancha({required this.tamano, required this.opacidad});

  final double tamano;
  final double opacidad;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: tamano,
      height: tamano,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: ColoresAplicacion.principal.withValues(alpha: opacidad),
      ),
    );
  }
}
