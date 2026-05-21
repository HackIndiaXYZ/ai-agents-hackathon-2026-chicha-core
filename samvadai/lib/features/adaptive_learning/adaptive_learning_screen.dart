import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../../agents/feedback_agent/feedback_agent.dart';
import '../../shared/widgets/glowing_button.dart';

class AdaptiveLearningScreen extends HookConsumerWidget {
  const AdaptiveLearningScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final originalController = useTextEditingController();
    final correctionController = useTextEditingController();
    
    // Dynamic refresh trigger
    final refresh = useState(0);

    final feedbackAgent = ref.watch(feedbackAgentProvider);

    void submitFeedback() {
      if (originalController.text.trim().isEmpty || correctionController.text.trim().isEmpty) return;
      
      feedbackAgent.recordCorrection(
        original: originalController.text,
        correction: correctionController.text,
        source: 'Hindi',
        target: 'English',
      );

      originalController.clear();
      correctionController.clear();
      refresh.value++; // Force UI rebuild
    }

    final learningProgress = feedbackAgent.getLearningProgressPercentage();
    final correctionsList = feedbackAgent.getCorrections();

    return Scaffold(
      backgroundColor: AppColors.backgroundVoid,
      appBar: AppBar(
        title: const Text('Adaptive AI Learning'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Visual AI progress curve
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const Text(
                          'Model Refinement Progress',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: 140,
                              height: 140,
                              child: CircularProgressIndicator(
                                value: learningProgress / 100.0,
                                color: AppColors.amberHighlight,
                                backgroundColor: AppColors.indigoPrimary,
                                strokeWidth: 12,
                              ),
                            ),
                            Text(
                              '${learningProgress.toStringAsFixed(0)}%',
                              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                    color: AppColors.amberHighlight,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'User alignment index matches local dialect vocabulary refinements.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Form to submit correction
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Suggest Translation Correction',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: originalController,
                          decoration: InputDecoration(
                            hintText: 'Original text (e.g. dawai le lo)...',
                            hintStyle: const TextStyle(color: AppColors.greyText),
                            filled: true,
                            fillColor: AppColors.backgroundVoid,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          style: const TextStyle(color: AppColors.warmWhite),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: correctionController,
                          decoration: InputDecoration(
                            hintText: 'Accurate translation suggestion...',
                            hintStyle: const TextStyle(color: AppColors.greyText),
                            filled: true,
                            fillColor: AppColors.backgroundVoid,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          style: const TextStyle(color: AppColors.warmWhite),
                        ),
                        const SizedBox(height: 20),
                        GlowingButton(
                          text: 'Submit Alignment Correction',
                          onPressed: submitFeedback,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // History of user corrections
                if (correctionsList.isNotEmpty) ...[
                  const Text(
                    'RECENT REINFORCEMENTS',
                    style: TextStyle(fontSize: 12, color: AppColors.greyText, fontWeight: FontWeight.bold, letterSpacing: 1.5),
                  ),
                  const SizedBox(height: 12),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: correctionsList.length,
                    itemBuilder: (context, index) {
                      final correction = correctionsList[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.greyCard,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.indigoPrimary),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Original: "${correction.originalText}"',
                              style: const TextStyle(color: AppColors.greyText, fontSize: 12),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Correction: "${correction.suggestedTranslation}"',
                              style: const TextStyle(color: AppColors.amberHighlight, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
