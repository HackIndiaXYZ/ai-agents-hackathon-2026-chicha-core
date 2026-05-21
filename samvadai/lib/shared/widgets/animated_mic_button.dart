import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';

class AnimatedMicButton extends StatelessWidget {
  final bool isRecording;
  final VoidCallback onTap;
  final double size;

  const AnimatedMicButton({
    super.key,
    required this.isRecording,
    required this.onTap,
    this.size = 80.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Pulse ripples behind mic when recording
          if (isRecording) ...[
            Container(
              width: size * 1.5,
              height: size * 1.5,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.glowAmber,
              ),
            ).animate(onPlay: (controller) => controller.repeat())
             .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.6, 1.6), duration: 1500.ms, curve: Curves.easeOut)
             .fadeOut(duration: 1500.ms),
            Container(
              width: size * 1.25,
              height: size * 1.25,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.glowViolet,
              ),
            ).animate(onPlay: (controller) => controller.repeat())
             .scale(begin: const Offset(0.9, 0.9), end: const Offset(1.3, 1.3), delay: 400.ms, duration: 1500.ms, curve: Curves.easeOut)
             .fadeOut(duration: 1500.ms),
          ],
          
          // Core button circle
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: (isRecording ? AppColors.amberHighlight : AppColors.violetAccent).withValues(alpha: 0.5),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
              gradient: LinearGradient(
                colors: isRecording
                    ? [AppColors.amberHighlight, AppColors.tealAccent]
                    : [AppColors.indigoPrimary, AppColors.violetAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Icon(
              isRecording ? Icons.mic : Icons.mic_none,
              size: size * 0.45,
              color: AppColors.warmWhite,
            ),
          ).animate(target: isRecording ? 1.0 : 0.0)
           .scale(begin: const Offset(1.0, 1.0), end: const Offset(1.1, 1.1), duration: 200.ms),
        ],
      ),
    );
  }
}
