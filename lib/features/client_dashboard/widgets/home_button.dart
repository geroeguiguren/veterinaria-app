import 'package:flutter/material.dart';

class BotonInicio extends StatelessWidget {
  const BotonInicio({
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