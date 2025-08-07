import 'package:flutter/material.dart';
import '../widgets/eco_button.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this, 
      duration: const Duration(milliseconds: 1500),
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 0.7, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 0.8, curve: Curves.easeOut),
      ),
    );

    _animationController.forward();

    // Navigate to main screen after a delay - uncomment if you want auto-navigation
    /*
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        _navigateToMainScreen(context, 0);
      }
    });
    */
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.9),
              Theme.of(context).colorScheme.primary.withOpacity(0.7),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const Spacer(flex: 2),
                _buildLogo(context),
                const SizedBox(height: 32),
                _buildTagline(context),
                const Spacer(flex: 1),
                _buildButtons(context),
                const Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Center(
            child: Icon(
              Icons.eco_rounded,
              size: 80,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTagline(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Column(
          children: [
            Text(
              "E-Waste Hub",
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              "Recycle Today, For a Better Tomorrow",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Column(
      children: [
        _buildAnimatedButton(
          EcoButton(
            text: "Submit E-Waste",
            icon: Icons.recycling_rounded,
            onPressed: () => _navigateToMainScreen(context, 2), // Submit is at index 2
          ),
          delay: 0.5,
        ),
        const SizedBox(height: 16),
        _buildAnimatedButton(
          EcoButton(
            text: "Find Repair",
            icon: Icons.build_rounded,
            onPressed: () => _navigateToMainScreen(context, 3), // Services is at index 3
          ),
          delay: 0.6,
        ),
        const SizedBox(height: 16),
        _buildAnimatedButton(
          EcoButton(
            text: "Browse Products",
            icon: Icons.view_module_rounded,
            onPressed: () => _navigateToMainScreen(context, 1), // Browse is at index 1
          ),
          delay: 0.7,
        ),
      ],
    );
  }

  Widget _buildAnimatedButton(Widget button, {required double delay}) {
    final Animation<double> delayedAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(delay, delay + 0.3, curve: Curves.easeOut),
      ),
    );

    return FadeTransition(
      opacity: delayedAnimation,
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Interval(delay, delay + 0.3, curve: Curves.easeOut),
          ),
        ),
        child: button,
      ),
    );
  }

  void _navigateToMainScreen(BuildContext context, int initialIndex) {
    Navigator.pushReplacementNamed(
      context, 
      '/main',
      arguments: initialIndex,
    );
  }
} 