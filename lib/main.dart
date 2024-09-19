import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mc_donals_api/screen/start/launcher_screen.dart';

void main() {
  // Asegurarse de que los bindings de Flutter estén inicializados
  WidgetsFlutterBinding.ensureInitialized();

  // Fijar la orientación de la pantalla a vertical
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LauncherScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
