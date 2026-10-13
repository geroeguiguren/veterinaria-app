import 'package:flutter/material.dart';

/// Colores de la identidad visual de Veterinaria.
class ColoresAplicacion {
  const ColoresAplicacion._();

  static const Color principal = Color(0xFF0F766E);
  static const Color principalOscuro = Color(0xFF115E59);
  static const Color secundario = Color(0xFF4F9B92);
  static const Color secundarioSuave = Color(0xFFE7F4F2);
  static const Color fondo = Color(0xFFF7F4EF);
  static const Color superficie = Color(0xFFFFFFFF);
  static const Color textoPrincipal = Color(0xFF1C2B29);
  static const Color textoSecundario = Color(0xFF5F6F6D);
  static const Color borde = Color(0xFFE6E1D8);
  static const Color error = Color(0xFFB42318);
}

class TemaAplicacion {
  const TemaAplicacion._();

  static ThemeData get claro {
    final esquemaDeColor =
        ColorScheme.fromSeed(
          seedColor: ColoresAplicacion.principal,
          brightness: Brightness.light,
        ).copyWith(
          primary: ColoresAplicacion.principal,
          onPrimary: Colors.white,
          secondary: ColoresAplicacion.secundario,
          onSecondary: Colors.white,
          surface: ColoresAplicacion.superficie,
          onSurface: ColoresAplicacion.textoPrincipal,
          onSurfaceVariant: ColoresAplicacion.textoSecundario,
          error: ColoresAplicacion.error,
          onError: Colors.white,
        );

    const radio = 14.0;

    return ThemeData(
      useMaterial3: true,
      colorScheme: esquemaDeColor,
      scaffoldBackgroundColor: ColoresAplicacion.fondo,
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          height: 1.2,
          letterSpacing: -0.4,
          color: ColoresAplicacion.textoPrincipal,
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.3,
          color: ColoresAplicacion.textoPrincipal,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          height: 1.4,
          color: ColoresAplicacion.textoSecundario,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          height: 1.4,
          color: ColoresAplicacion.textoSecundario,
        ),
        labelLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ColoresAplicacion.secundarioSuave,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        prefixIconColor: ColoresAplicacion.principal,
        suffixIconColor: ColoresAplicacion.textoSecundario,
        labelStyle: const TextStyle(color: ColoresAplicacion.textoSecundario),
        floatingLabelStyle: const TextStyle(
          color: ColoresAplicacion.principal,
          fontWeight: FontWeight.w600,
        ),
        errorStyle: const TextStyle(
          color: ColoresAplicacion.error,
          fontSize: 12,
          height: 1.3,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radio),
          borderSide: const BorderSide(color: ColoresAplicacion.borde),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radio),
          borderSide: const BorderSide(color: ColoresAplicacion.borde),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radio),
          borderSide: const BorderSide(
            color: ColoresAplicacion.principal,
            width: 1.6,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radio),
          borderSide: const BorderSide(color: ColoresAplicacion.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radio),
          borderSide: const BorderSide(
            color: ColoresAplicacion.error,
            width: 1.6,
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(54),
          backgroundColor: ColoresAplicacion.principal,
          foregroundColor: Colors.white,
          disabledBackgroundColor: ColoresAplicacion.principal.withValues(
            alpha: 0.4,
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: ColoresAplicacion.principal,
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: ColoresAplicacion.principalOscuro,
        contentTextStyle: const TextStyle(color: Colors.white, fontSize: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
      ),
    );
  }
}
