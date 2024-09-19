import 'package:flutter/material.dart';

class McMenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEC208), // Color de fondo amarillo
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Acción del botón aquí si es necesario
          },
          child: const Text('Hola'),
        ),
      ),
    );
  }
}
