import 'package:flutter/material.dart';

class BotonAutenticacion extends StatelessWidget {
  const BotonAutenticacion({
    super.key,
    required this.etiqueta,
    required this.onPressed,
  });

  final String etiqueta;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(onPressed: onPressed, child: Text(etiqueta)),
    );
  }
}
