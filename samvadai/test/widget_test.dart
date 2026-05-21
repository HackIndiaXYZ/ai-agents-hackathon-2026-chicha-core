import 'package:flutter_test/flutter_test.dart';
import 'package:samvadai/agents/translation_agent/translation_agent.dart';

void main() {
  group('TranslationAgent Tests', () {
    final agent = TranslationAgent();

    test('Translates Hindi mock phrase to English correctly', () async {
      final result = await agent.translate(
        text: 'namaste, mujhe hospital jana hai',
        sourceLang: 'Hindi',
        targetLang: 'English',
      );
      expect(result, equals('Hello, I need to go to the hospital.'));
    });

    test('Detects code-mixed sentences correctly', () {
      final isMixed = agent.detectCodeMixed('Hello! आप कैसे हो?');
      expect(isMixed, isTrue);
    });

    test('Detects monolingual sentences correctly', () {
      final isMixed = agent.detectCodeMixed('Hello how are you?');
      expect(isMixed, isFalse);
    });
  });
}
