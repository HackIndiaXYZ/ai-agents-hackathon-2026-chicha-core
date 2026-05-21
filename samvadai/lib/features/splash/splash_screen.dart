import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    await Future.delayed(const Duration(milliseconds: 3200));
    if (mounted) {
      context.go('/onboarding');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundVoid,
      body: Stack(
        children: [
          // Neural background glow
          Center(
            child: Container(
              width: 300,
              height: 300,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.glowViolet,
              ),
            ).animate(onPlay: (controller) => controller.repeat(reverse: true))
             .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.2, 1.2), duration: 2500.ms)
             .blur(begin: const Offset(20, 20), end: const Offset(40, 40)),
          ),
          
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Futuristic Logo representation
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.violetAccent, width: 2),
                        boxShadow: const [
                          BoxShadow(
                            color: AppColors.glowViolet,
                            blurRadius: 20,
                            spreadRadius: 2,
                          )
                        ],
                      ),
                    ).animate().rotate(duration: 4000.ms),
                    const Icon(
                      Icons.bubble_chart_rounded,
                      size: 50,
                      color: AppColors.amberHighlight,
                    ).animate().scale(duration: 1000.ms, curve: Curves.bounceOut),
                  ],
                ),
                const SizedBox(height: 30),
                Text(
                  'SamvadAI',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: AppColors.warmWhite,
                        fontWeight: FontWeight.bold,
                      ),
                ).animate().fadeIn(delay: 500.ms, duration: 800.ms).slideY(begin: 0.2, end: 0),
                const SizedBox(height: 10),
                Text(
                  'Bridging India\'s 1,600+ languages',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.greyText,
                      ),
                ).animate().fadeIn(delay: 1000.ms, duration: 800.ms),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
