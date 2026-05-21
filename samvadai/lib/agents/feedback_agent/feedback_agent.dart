import 'package:flutter_riverpod/flutter_riverpod.dart';

class TranslationCorrection {
  final String originalText;
  final String suggestedTranslation;
  final String sourceLang;
  final String targetLang;
  final DateTime timestamp;

  TranslationCorrection({
    required this.originalText,
    required this.suggestedTranslation,
    required this.sourceLang,
    required this.targetLang,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
        'originalText': originalText,
        'suggestedTranslation': suggestedTranslation,
        'sourceLang': sourceLang,
        'targetLang': targetLang,
        'timestamp': timestamp.toIso8601String(),
      };
}

class FeedbackAgent {
  final List<TranslationCorrection> _corrections = [];

  void recordCorrection({
    required String original,
    required String correction,
    required String source,
    required String target,
  }) {
    _corrections.add(
      TranslationCorrection(
        originalText: original,
        suggestedTranslation: correction,
        sourceLang: source,
        targetLang: target,
        timestamp: DateTime.now(),
      ),
    );
  }

  List<TranslationCorrection> getCorrections() => List.unmodifiable(_corrections);

  double getLearningProgressPercentage() {
    // Simulated learning reinforcement metric
    if (_corrections.isEmpty) return 0.0;
    return (_corrections.length * 15.0).clamp(0.0, 100.0);
  }
}

final feedbackAgentProvider = Provider<FeedbackAgent>((ref) {
  return FeedbackAgent();
});
