import 'package:flutter/material.dart';
import 'dart:async';

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
  String displayMcDonaldsText = "";
  String displayLovinText = "";
  final String mcDonaldsText = "McDonald's";
  final String lovinText = "I'm lovin' it";
  bool startLovinText = false;
  late Timer _textTimer;

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

    _imageSlideAnimation = Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0, -0.2)).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _imageScaleAnimation = Tween<double>(begin: 1.5, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

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
      }
    });
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
      body: Center(
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
    );
  }
}
