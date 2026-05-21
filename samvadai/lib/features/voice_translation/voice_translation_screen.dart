import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/widgets/voice_waveform.dart';
import '../../shared/widgets/animated_mic_button.dart';
import '../../shared/widgets/translation_bubble.dart';

class VoiceTranslationScreen extends HookConsumerWidget {
  const VoiceTranslationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isListening = useState(false);
    final selectedSourceLang = useState('Hindi');
    final selectedTargetLang = useState('English');
    
    // Core conversations log list
    final conversations = useState<List<Map<String, dynamic>>>([
      {
        'text': 'नमस्ते, मुझे अस्पताल जाना है।',
        'translation': 'Hello, I need to go to the hospital.',
        'source': 'Hindi',
        'target': 'English',
        'isUser': true,
      },
      {
        'text': 'Sure, please sit down. The doctor will check you shortly.',
        'translation': 'ज़रूर, कृपया बैठिए। डॉक्टर जल्द ही आपकी जाँच करेंगे।',
        'source': 'English',
        'target': 'Hindi',
        'isUser': false,
      }
    ]);

    void simulateVoiceInput() async {
      if (isListening.value) {
        isListening.value = false;
        return;
      }
      
      isListening.value = true;
      
      // Simulate speaking for 3 seconds
      await Future.delayed(const Duration(seconds: 3));
      
      if (isListening.value) {
        isListening.value = false;
        // Inject a new voice translation bubble
        conversations.value = [
          ...conversations.value,
          {
            'text': 'kya haal hai? khana khaya?',
            'translation': 'How are you? Did you eat food?',
            'source': 'Hindi',
            'target': 'English',
            'isUser': true,
          }
        ];
      }
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundVoid,
      appBar: AppBar(
        title: const Text('Voice Conversation'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sync_rounded, color: AppColors.tealAccent),
            onPressed: () {
              // Reset simulated log
              conversations.value = [];
            },
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Top live active agents banner
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              color: AppColors.indigoPrimary.withValues(alpha: 0.4),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lens, color: AppColors.tealAccent, size: 8),
                  SizedBox(width: 8),
                  Text(
                    'LIVE TRANSLATION • 3 AGENTS ACTIVE',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: AppColors.tealAccent,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),

            // Scrollable Conversation logs
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 16),
                physics: const BouncingScrollPhysics(),
                itemCount: conversations.value.length,
                itemBuilder: (context, index) {
                  final bubble = conversations.value[index];
                  return TranslationBubble(
                    text: bubble['text'],
                    translation: bubble['translation'],
                    sourceLanguage: bubble['source'],
                    targetLanguage: bubble['target'],
                    isUser: bubble['isUser'],
                  );
                },
              ),
            ),

            // Lower input zone containing visualizers
            Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: AppColors.greyCard,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
                border: Border.all(color: AppColors.indigoPrimary, width: 1.5),
              ),
              child: Column(
                children: [
                  // Real-time audio signal viz
                  VoiceWaveform(isListening: isListening.value),
                  const SizedBox(height: 16),

                  // Language selection chips row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildLangChip(selectedSourceLang.value, true),
                      const Icon(Icons.compare_arrows_rounded, color: AppColors.violetAccent),
                      _buildLangChip(selectedTargetLang.value, false),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Large voice mic button
                  Center(
                    child: AnimatedMicButton(
                      isRecording: isListening.value,
                      onTap: simulateVoiceInput,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isListening.value ? 'Listening to voice...' : 'Tap to speak',
                    style: TextStyle(
                      color: isListening.value ? AppColors.amberHighlight : AppColors.greyText,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLangChip(String label, bool isSource) {
    final activeColor = isSource ? AppColors.violetAccent : AppColors.tealAccent;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: activeColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: activeColor, width: 1.5),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: activeColor,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}
