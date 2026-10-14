import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veterinaria_app/app/app.dart';
import 'package:veterinaria_app/app/theme/app_theme.dart';
import 'package:veterinaria_app/features/cliente/pages/home_cliente_page.dart';

void main() {
  testWidgets('muestra login y navega a registro', (tester) async {
    await tester.pumpWidget(const AplicacionVeterinaria());

    expect(find.text('Bienvenido de nuevo'), findsOneWidget);
    expect(find.text('Ingresar'), findsOneWidget);

    await tester.tap(find.text('Crear cuenta'));
    await tester.pumpAndSettle();

    expect(find.text('Crear cuenta'), findsWidgets);
    expect(find.text('Registrarme'), findsOneWidget);

    final enlaceLogin = find.text('Iniciar sesión');
    await tester.ensureVisible(enlaceLogin);
    await tester.pumpAndSettle();
    await tester.tap(enlaceLogin);
    await tester.pumpAndSettle();

    expect(find.text('Bienvenido de nuevo'), findsOneWidget);
  });

  testWidgets('valida el login y abre el inicio del cliente', (tester) async {
    await tester.pumpWidget(const AplicacionVeterinaria());

    await tester.tap(find.text('Ingresar'));
    await tester.pump();

    expect(find.text('Ingresá tu email'), findsOneWidget);
    expect(find.text('Ingresá tu contraseña'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).at(0), 'correo-invalido');
    await tester.enterText(find.byType(TextFormField).at(1), '123');
    await tester.tap(find.text('Ingresar'));
    await tester.pump();

    expect(find.text('Ingresá un email válido'), findsOneWidget);
    expect(
      find.text('La contraseña debe tener al menos 6 caracteres'),
      findsOneWidget,
    );

    await tester.enterText(find.byType(TextFormField).at(0), ' ana@mail.com ');
    await tester.enterText(find.byType(TextFormField).at(1), '123456');
    await tester.tap(find.text('Ingresar'));
    await tester.pumpAndSettle();

    expect(find.text('Próximos turnos'), findsOneWidget);
  });

  testWidgets('valida el registro', (tester) async {
    await tester.pumpWidget(const AplicacionVeterinaria());

    await tester.tap(find.text('Crear cuenta'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(0), 'A');
    await tester.enterText(find.byType(TextFormField).at(1), 'ana@mail.com');
    await tester.enterText(find.byType(TextFormField).at(2), '123456');
    await tester.enterText(find.byType(TextFormField).at(3), '654321');
    await tester.tap(find.text('Registrarme'));
    await tester.pump();

    expect(
      find.text('El nombre debe tener al menos 2 caracteres'),
      findsOneWidget,
    );
    expect(find.text('Las contraseñas no coinciden'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).at(0), 'Ana');
    await tester.enterText(find.byType(TextFormField).at(3), '123456');
    await tester.tap(find.text('Registrarme'));
    await tester.pump();

    expect(find.text('Cuenta creada correctamente'), findsOneWidget);
  });

  testWidgets('no desborda en una pantalla chica ni con teclado', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 568);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const AplicacionVeterinaria());
    expect(find.text('Bienvenido de nuevo'), findsOneWidget);

    tester.view.viewInsets = const FakeViewPadding(bottom: 280);
    await tester.pump();

    final crearCuenta = find.text('Crear cuenta');
    await tester.ensureVisible(crearCuenta);
    await tester.pumpAndSettle();
    await tester.tap(crearCuenta);
    await tester.pumpAndSettle();
    expect(find.text('Registrarme'), findsOneWidget);
  });

  testWidgets('el inicio del cliente muestra accesos y próximos turnos', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(theme: TemaAplicacion.claro, home: const PaginaHomeCliente()),
    );

    expect(find.text('Mis Mascotas'), findsOneWidget);
    expect(find.text('Reservar Turno'), findsOneWidget);
    expect(find.text('Mis Turnos'), findsOneWidget);
    expect(find.text('Firulais'), findsOneWidget);
    expect(find.text('Tyson'), findsOneWidget);
  });
}
