import 'package:flutter/material.dart';
import 'package:mc_donals_api/util/background/home_background.dart';

class McMenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          HomeBackground(),

          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.20),
              // padding: const EdgeInsets.symmetric(vertical: 140.0), // Padding superior e inferior
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 20.0, 
                crossAxisSpacing: 20.0, 
                padding: const EdgeInsets.all(20.0), 
                children: [
                  _buildMenuButton(
                    icon: Icons.fastfood,
                    label: 'Hamburguesas',
                    onPressed: () {

                    },
                  ),
                  _buildMenuButton(
                    icon: Icons.local_drink,
                    label: 'Bebidas',
                    onPressed: () {

                    },
                  ),
                  _buildMenuButton(
                    icon: Icons.cake,
                    label: 'Postres',
                    onPressed: () {

                    },
                  ),
                  _buildMenuButton(
                    icon: Icons.settings,
                    label: 'Ajustes',
                    onPressed: () {

                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black, 
        backgroundColor: Colors.white.withOpacity(0.7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0), 
        ),
        padding: const EdgeInsets.all(20.0), 
      ),
      onPressed: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 50.0), 
          const SizedBox(height: 10.0),
          Text(
            label,
            style: const TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    );
  }
}
