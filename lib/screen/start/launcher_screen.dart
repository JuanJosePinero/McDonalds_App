import 'package:flutter/material.dart';
import 'dart:async';

import 'package:mc_donals_api/screen/home/mcmenu.dart';

class LauncherScreen extends StatefulWidget {
  const LauncherScreen({super.key});

  @override
  State<LauncherScreen> createState() => _LauncherScreenState();
}

class _LauncherScreenState extends State<LauncherScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _imageSlideAnimation;
  late Animation<double> _imageScaleAnimation;
  late Animation<double> _buttonFadeAnimation;
  late Animation<Offset> _buttonSlideAnimation;
  late Animation<double> _buttonScaleAnimation;

  String displayMcDonaldsText = "";
  String displayLovinText = "";
  final String mcDonaldsText = "McDonald's";
  final String lovinText = "I'm lovin' it";
  late Timer _textTimer;
  bool showButton = false;
  bool buttonAnimated = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _imageSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, -0.2),
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

    _imageScaleAnimation = Tween<double>(
      begin: 1.5,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

    // Animaciones para el botón
    _buttonFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _buttonSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, -0.2),
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

    _buttonScaleAnimation = Tween<double>(
      begin: 1.5,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

    _animationController.forward();

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _startMcDonaldsTextAnimation();
      }
    });
  }

  void _startMcDonaldsTextAnimation() {
    int currentIndex = 0;

    _textTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        displayMcDonaldsText += mcDonaldsText[currentIndex];
        currentIndex++;
      });

      if (currentIndex == mcDonaldsText.length) {
        timer.cancel();
        Future.delayed(const Duration(milliseconds: 500), () {
          _startLovinTextAnimation();
        });
      }
    });
  }

  void _startLovinTextAnimation() {
    int currentIndex = 0;
    _textTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        displayLovinText += lovinText[currentIndex];
        currentIndex++;
      });

      if (currentIndex == lovinText.length) {
        timer.cancel();
        Future.delayed(const Duration(milliseconds: 500), () {
          _animateButton();
        });
      }
    });
  }

  void _animateButton() {
    setState(() {
      showButton = true;
    });

    // Crear las animaciones para el botón
    _animationController.forward().whenComplete(() {
      setState(() {
        buttonAnimated = true;
      });
    });
  }

  // Función para redirigir a la pantalla McMenuScreen con una animación circular
void _navigateToMenuScreen(BuildContext context) {
  Navigator.of(context).push(
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => McMenuScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return ClipPath(
          clipper: CircleRevealClipper(
            fraction: animation.value,
          ),
          child: child,
        );
      },
      transitionDuration: const Duration(seconds: 1),
    ),
  );
}

  @override
  void dispose() {
    _animationController.dispose();
    _textTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEC208),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: ScaleTransition(
                    scale: _imageScaleAnimation,
                    child: SlideTransition(
                      position: _imageSlideAnimation,
                      child: FractionallySizedBox(
                        widthFactor: 0.6,
                        child: Image.asset(
                          'assets/images/mcdonald_logo.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Text(
                    displayMcDonaldsText,
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF2D08),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Text(
                    displayLovinText,
                    style: const TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (showButton)
            Positioned(
              bottom: 100, // Espacio desde el fondo
              left: 100,
              right: 100,
              child: buttonAnimated
                  ? FadeTransition(
                      opacity: _buttonFadeAnimation,
                      child: ScaleTransition(
                        scale: _buttonScaleAnimation,
                        child: SlideTransition(
                          position: _buttonSlideAnimation,
                          child: ElevatedButton(
                            onPressed: () {
                              _navigateToMenuScreen(context); // Redirige con animación
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: const Color(0xFFFEC208),
                              backgroundColor: const Color(0xFF23512f), // Color del texto amarillo
                            ),
                            child: const Text('START'),
                          ),
                        ),
                      ),
                    )
                  : Container(), // Ocultar el botón hasta que se complete la animación
            ),
        ],
      ),
    );
  }
}

// Clipper personalizado para crear la animación de círculo
class CircleRevealClipper extends CustomClipper<Path> {
  final double fraction;

  CircleRevealClipper({required this.fraction});

  @override
  Path getClip(Size size) {
    final path = Path();
    final radius = size.width * fraction * 2;
    path.addOval(Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: radius));
    return path;
  }

  @override
  bool shouldReclip(CircleRevealClipper oldClipper) {
    return fraction != oldClipper.fraction;
  }
}
