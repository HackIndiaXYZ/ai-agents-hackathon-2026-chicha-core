import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../../core/accessibility/accessibility_service.dart';

class AccessibilityCenterScreen extends HookConsumerWidget {
  const AccessibilityCenterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accState = ref.watch(accessibilityProvider);
    final accNotifier = ref.read(accessibilityProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.backgroundVoid,
      appBar: AppBar(
        title: const Text('Accessibility Center'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Elderly Mode Preset Card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Elderly-Friendly UI (ElderMode)',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Switch(
                              value: accState.isElderlyFriendly,
                              activeThumbColor: AppColors.amberHighlight,
                              onChanged: (_) => accNotifier.toggleElderlyFriendly(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Activating this configures larger click regions, activates voice support systems, and enlarges all type sizing parameters instantly.',
                          style: TextStyle(color: AppColors.greyText, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Individual toggles List
                const Text(
                  'MANUAL ADJUSTMENTS',
                  style: TextStyle(fontSize: 12, color: AppColors.greyText, fontWeight: FontWeight.bold, letterSpacing: 1.5),
                ),
                const SizedBox(height: 12),
                
                _buildToggleItem(
                  context: context,
                  title: 'Voice-First Navigation',
                  description: 'Spoken text confirmation assists navigation and results reading.',
                  value: accState.isVoiceFirstMode,
                  onChanged: (_) => accNotifier.toggleVoiceFirstMode(),
                  activeColor: AppColors.violetAccent,
                ),
                
                _buildToggleItem(
                  context: context,
                  title: 'High Contrast Mode',
                  description: 'Boost text contrasts for outdoor or low-visibility comfort.',
                  value: accState.isHighContrast,
                  onChanged: (_) => accNotifier.toggleHighContrast(),
                  activeColor: AppColors.tealAccent,
                ),

                // Font slider controller
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.greyCard,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.indigoPrimary),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Text Size Scaling',
                            style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.warmWhite),
                          ),
                          Text(
                            '${(accState.fontSizeMultiplier * 100).toStringAsFixed(0)}%',
                            style: const TextStyle(color: AppColors.violetAccent, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Slider(
                        value: accState.fontSizeMultiplier,
                        min: 0.8,
                        max: 1.6,
                        divisions: 8,
                        activeColor: AppColors.violetAccent,
                        inactiveColor: AppColors.indigoPrimary,
                        onChanged: (val) => accNotifier.updateFontSize(val),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildToggleItem({
    required BuildContext context,
    required String title,
    required String description,
    required bool value,
    required ValueChanged<bool> onChanged,
    required Color activeColor,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.greyCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.indigoPrimary),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.warmWhite),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(color: AppColors.greyText, fontSize: 12),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            activeThumbColor: activeColor,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
