import 'package:flutter/material.dart';

class McMenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: const Color(0xFFeaa767), // Color #eaa767
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: const Color(0xFFc20d00), // Color #c20d00
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: const Color(0xFF149741), // Color #149741 (centro)
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Acción del botón aquí si es necesario
                  },
                  child: const Text('Hola'),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: const Color(0xFF863b27), // Color #863b27
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: const Color(0xFFeaa767), // Color #eaa767 de nuevo
            ),
          ),
        ],
      ),
    );
  }
}
