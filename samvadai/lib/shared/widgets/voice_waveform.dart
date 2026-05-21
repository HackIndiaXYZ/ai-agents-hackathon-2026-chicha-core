import 'dart:math';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class VoiceWaveform extends StatefulWidget {
  final bool isListening;
  final Color color;

  const VoiceWaveform({
    super.key,
    required this.isListening,
    this.color = AppColors.violetAccent,
  });

  @override
  State<VoiceWaveform> createState() => _VoiceWaveformState();
}

class _VoiceWaveformState extends State<VoiceWaveform>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    if (widget.isListening) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant VoiceWaveform oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isListening) {
      _controller.repeat();
    } else {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(24, (index) {
              double animatedHeight = 4.0;
              if (widget.isListening) {
                // Generate simulated audio signal amplitudes
                animatedHeight = 4.0 +
                    (_random.nextDouble() * 40.0) *
                        sin((_controller.value * 2 * pi) + (index * 0.5)).abs();
              }
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 2.0),
                width: 3.5,
                height: animatedHeight,
                decoration: BoxDecoration(
                  color: widget.color.withValues(
                      alpha: widget.isListening ? (0.4 + (animatedHeight / 80)) : 0.3),
                  borderRadius: BorderRadius.circular(2.0),
                  boxShadow: widget.isListening
                      ? [
                          BoxShadow(
                            color: widget.color.withValues(alpha: 0.3),
                            blurRadius: 4,
                            spreadRadius: 0.5,
                          )
                        ]
                      : null,
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
