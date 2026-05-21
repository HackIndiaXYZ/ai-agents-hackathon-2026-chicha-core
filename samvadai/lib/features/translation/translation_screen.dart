import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../../agents/translation_agent/translation_agent.dart';
import '../../shared/widgets/glowing_button.dart';

class TranslationScreen extends HookConsumerWidget {
  const TranslationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController();
    final sourceLang = useState('Hindi');
    final targetLang = useState('English');
    final translatedOutput = useState('');
    final isTranslating = useState(false);

    final translationAgent = ref.watch(translationAgentProvider);

    void handleTranslate() async {
      if (textController.text.trim().isEmpty) return;
      isTranslating.value = true;
      try {
        final result = await translationAgent.translate(
          text: textController.text,
          sourceLang: sourceLang.value,
          targetLang: targetLang.value,
        );
        translatedOutput.value = result;
      } finally {
        isTranslating.value = false;
      }
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundVoid,
      appBar: AppBar(
        title: const Text('Text Translation'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Language selectors
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildLanguageDropdown(context, sourceLang, ['Hindi', 'English', 'Tamil', 'Marathi', 'Bengali']),
                    const Icon(Icons.swap_horiz_rounded, color: AppColors.violetAccent, size: 28),
                    _buildLanguageDropdown(context, targetLang, ['English', 'Hindi', 'Tamil', 'Marathi', 'Bengali']),
                  ],
                ),
                const SizedBox(height: 24),

                // Source input Card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              sourceLang.value,
                              style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.violetAccent),
                            ),
                            if (textController.text.isNotEmpty)
                              IconButton(
                                icon: const Icon(Icons.clear, size: 18),
                                onPressed: () {
                                  textController.clear();
                                  translatedOutput.value = '';
                                },
                              ),
                          ],
                        ),
                        const Divider(color: AppColors.indigoPrimary),
                        TextField(
                          controller: textController,
                          maxLines: 4,
                          decoration: const InputDecoration(
                            hintText: 'Enter speech text here to translate...',
                            hintStyle: TextStyle(color: AppColors.greyText),
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(color: AppColors.warmWhite, fontSize: 16),
                          onChanged: (_) {
                            // optional real-time trigger or debouncing
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Translate Trigger
                GlowingButton(
                  text: isTranslating.value ? 'Translating via AI...' : 'Translate Now',
                  onPressed: handleTranslate,
                  icon: Icons.auto_awesome,
                ),
                const SizedBox(height: 24),

                // Output Card
                if (translatedOutput.value.isNotEmpty || isTranslating.value)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                targetLang.value,
                                style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.tealAccent),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.copy_rounded, size: 18),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.volume_up, size: 18),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Divider(color: AppColors.indigoPrimary),
                          if (isTranslating.value)
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 24.0),
                              child: Center(
                                child: CircularProgressIndicator(color: AppColors.tealAccent),
                              ),
                            )
                          else
                            Text(
                              translatedOutput.value,
                              style: const TextStyle(
                                color: AppColors.warmWhite,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageDropdown(BuildContext context, ValueNotifier<String> controller, List<String> items) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.greyCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.indigoPrimary),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: controller.value,
          dropdownColor: AppColors.greyCard,
          items: items.map((String val) {
            return DropdownMenuItem<String>(
              value: val,
              child: Text(val, style: const TextStyle(color: AppColors.warmWhite)),
            );
          }).toList(),
          onChanged: (newVal) {
            if (newVal != null) {
              controller.value = newVal;
            }
          },
        ),
      ),
    );
  }
}
