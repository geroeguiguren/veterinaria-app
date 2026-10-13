import 'package:flutter/material.dart';

class CampoAutenticacion extends StatelessWidget {
  const CampoAutenticacion({
    super.key,
    required this.controller,
    required this.etiqueta,
    required this.icono,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.textCapitalization = TextCapitalization.none,
    this.obscureText = false,
    this.alAlternarVisibilidad,
    this.validator,
    this.onFieldSubmitted,
    this.autofillHints,
  });

  final TextEditingController controller;
  final String etiqueta;
  final IconData icono;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final bool obscureText;
  final VoidCallback? alAlternarVisibilidad;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final Iterable<String>? autofillHints;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      obscureText: obscureText,
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
      autofillHints: autofillHints,
      autocorrect: keyboardType != TextInputType.emailAddress && !obscureText,
      enableSuggestions: !obscureText,
      decoration: InputDecoration(
        labelText: etiqueta,
        prefixIcon: Icon(icono),
        suffixIcon: alAlternarVisibilidad == null
            ? null
            : IconButton(
                onPressed: alAlternarVisibilidad,
                tooltip: obscureText
                    ? 'Mostrar contraseña'
                    : 'Ocultar contraseña',
                icon: Icon(
                  obscureText
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
              ),
      ),
    );
  }
}
