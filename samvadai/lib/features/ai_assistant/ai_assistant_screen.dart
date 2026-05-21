import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../../agents/context_agent/context_agent.dart';

class AiAssistantScreen extends HookConsumerWidget {
  const AiAssistantScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeMode = useState<ContextMode>(ContextMode.general);
    final textController = useTextEditingController();
    
    // Chat logs list
    final chatMessages = useState<List<Map<String, dynamic>>>([
      {
        'text': 'Namaste! I am your SamvadAI assistant. How can I help you in your preferred language today?',
        'isUser': false,
      }
    ]);

    final contextAgent = ref.watch(contextAgentProvider);

    void switchMode(ContextMode mode) {
      activeMode.value = mode;
      final systemPrompt = contextAgent.getSystemPrompt(mode);
      
      chatMessages.value = [
        ...chatMessages.value,
        {
          'text': 'Switched to ${mode.name.toUpperCase()} Mode.\nPrompt: "$systemPrompt"',
          'isUser': false,
        }
      ];
    }

    void handleSendMessage() async {
      if (textController.text.trim().isEmpty) return;
      final userText = textController.text;
      textController.clear();

      chatMessages.value = [
        ...chatMessages.value,
        {'text': userText, 'isUser': true}
      ];

      // Simulated AI cognitive reply
      await Future.delayed(const Duration(milliseconds: 1000));
      
      // Auto-detect context switch recommendation if context shifts
      final detected = contextAgent.detectContext(userText);
      String reply = 'I processed your request in General Mode.';
      
      if (activeMode.value == ContextMode.healthcare || detected == ContextMode.healthcare) {
        reply = 'Medical Agent: We advise consulting a certified doctor. Local pharmacy details are retrieved.';
      } else if (activeMode.value == ContextMode.education || detected == ContextMode.education) {
        reply = 'Academic Agent: Let\'s outline the primary topics. This syllabus guide is mapped to local state standards.';
      } else if (activeMode.value == ContextMode.governance || detected == ContextMode.governance) {
        reply = 'Governance Agent: This scheme requires your Aadhaar registration. Let\'s outline the registration steps.';
      }

      chatMessages.value = [
        ...chatMessages.value,
        {'text': reply, 'isUser': false}
      ];
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundVoid,
      appBar: AppBar(
        title: const Text('Conversational AI'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Floating context selector row
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: [
                    _buildModeButton('General', ContextMode.general, activeMode.value, switchMode),
                    _buildModeButton('Healthcare', ContextMode.healthcare, activeMode.value, switchMode),
                    _buildModeButton('Education', ContextMode.education, activeMode.value, switchMode),
                    _buildModeButton('Governance', ContextMode.governance, activeMode.value, switchMode),
                  ],
                ),
              ),
            ),

            // Scrollable messages area
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                physics: const BouncingScrollPhysics(),
                itemCount: chatMessages.value.length,
                itemBuilder: (context, index) {
                  final message = chatMessages.value[index];
                  final isUser = message['isUser'];
                  return Align(
                    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 6.0),
                      padding: const EdgeInsets.all(16.0),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.75,
                      ),
                      decoration: BoxDecoration(
                        color: isUser ? AppColors.violetAccent.withValues(alpha: 0.15) : AppColors.indigoPrimary.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isUser ? AppColors.violetAccent : AppColors.indigoPrimary,
                        ),
                      ),
                      child: Text(
                        message['text'],
                        style: TextStyle(
                          color: AppColors.warmWhite,
                          fontSize: 14,
                          fontWeight: isUser ? FontWeight.normal : FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Chat input bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                color: AppColors.greyCard,
                border: Border(
                  top: BorderSide(color: AppColors.indigoPrimary, width: 1.5),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: textController,
                      decoration: const InputDecoration(
                        hintText: 'Ask in any regional language...',
                        hintStyle: TextStyle(color: AppColors.greyText),
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(color: AppColors.warmWhite),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send_rounded, color: AppColors.violetAccent),
                    onPressed: handleSendMessage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModeButton(
    String label,
    ContextMode mode,
    ContextMode active,
    Function(ContextMode) onSwitch,
  ) {
    final isSelected = active == mode;
    return GestureDetector(
      onTap: () => onSwitch(mode),
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isSelected ? AppColors.amberHighlight.withValues(alpha: 0.2) : AppColors.indigoPrimary.withValues(alpha: 0.4),
          border: Border.all(
            color: isSelected ? AppColors.amberHighlight : AppColors.indigoPrimary,
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppColors.amberHighlight : AppColors.warmWhite,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
