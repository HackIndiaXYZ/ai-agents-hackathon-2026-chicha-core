import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/widgets/glowing_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> _slides = [
    {
      'title': 'Bridging India\'s Languages',
      'subtitle': 'SamvadAI is an adaptive multilingual platform enabling real-time translation, speech-to-text, and dialect understanding across India\'s regional languages.',
      'icon': 'translate',
    },
    {
      'title': 'Inclusive & Voice-First',
      'subtitle': 'Built for everyone, including elder-friendly touch targets, voice navigation, and localized dialect models representing true regional speech pattern nuances.',
      'icon': 'mic',
    },
    {
      'title': 'Offline-First Intelligence',
      'subtitle': 'No internet? No worries. Download lightweight language packs and get real-time offline translations for critical and emergency needs.',
      'icon': 'wifi_off',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundVoid,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              // Header top action
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => context.go('/auth'),
                  child: Text(
                    'Skip',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppColors.violetAccent,
                        ),
                  ),
                ),
              ),
              
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemCount: _slides.length,
                  itemBuilder: (context, index) {
                    final slide = _slides[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Slide representation icon
                        Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.indigoPrimary.withValues(alpha: 0.4),
                            border: Border.all(color: AppColors.violetAccent.withValues(alpha: 0.3)),
                          ),
                          child: Icon(
                            _getSlideIcon(slide['icon']!),
                            size: 64,
                            color: AppColors.amberHighlight,
                          ),
                        ),
                        const SizedBox(height: 48),
                        Text(
                          slide['title']!,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          slide['subtitle']!,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: AppColors.greyText,
                              ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              // Page indicators & Next button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Dot Indicators
                  Row(
                    children: List.generate(
                      _slides.length,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentIndex == index ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: _currentIndex == index
                              ? AppColors.amberHighlight
                              : AppColors.greyText.withValues(alpha: 0.4),
                        ),
                      ),
                    ),
                  ),

                  // Action Button
                  GlowingButton(
                    text: _currentIndex == _slides.length - 1 ? 'Get Started' : 'Next',
                    onPressed: () {
                      if (_currentIndex == _slides.length - 1) {
                        context.go('/auth');
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getSlideIcon(String key) {
    switch (key) {
      case 'translate':
        return Icons.translate_rounded;
      case 'mic':
        return Icons.keyboard_voice_rounded;
      case 'wifi_off':
        return Icons.signal_wifi_off_rounded;
      default:
        return Icons.help_outline;
    }
  }
}
