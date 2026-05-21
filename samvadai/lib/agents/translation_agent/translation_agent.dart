import 'package:flutter_riverpod/flutter_riverpod.dart';

class TranslationAgent {
  // Multilingual Indian translations simulation database
  final Map<String, Map<String, String>> _mockDb = {
    'namaste, mujhe hospital jana hai': {
      'English': 'Hello, I need to go to the hospital.',
      'Tamil': 'வணக்கம், நான் மருத்துவமனைக்குச் செல்ல வேண்டும்.',
      'Bengali': 'নমস্কার, আমাকে হাসপাতালে যেতে হবে।'
    },
    'hello, i need to go to the hospital.': {
      'Hindi': 'नमस्ते, मुझे अस्पताल जाना है।',
      'Tamil': 'வணக்கம், நான் மருத்துவமனைக்குச் செல்ல வேண்டும்.',
      'Bengali': 'নমস্কার, আমাকে হাসপাতালে যেতে হবে।'
    },
    'kya haal hai? khana khaya?': {
      'English': 'How are you? Did you eat food?',
      'Tamil': 'எப்படி இருக்கிறீர்கள்? சாப்பிட்டீர்களா?',
      'Marathi': 'कसे आहात? जेवण झाले का?'
    }
  };

  Future<String> translate({
    required String text,
    required String sourceLang,
    required String targetLang,
    bool isCodeMixed = false,
  }) async {
    await Future.delayed(const Duration(milliseconds: 600)); // AI simulation speed

    final lowercaseText = text.trim().toLowerCase();
    
    // Look up in mock database
    for (var key in _mockDb.keys) {
      if (key.toLowerCase() == lowercaseText) {
        final translations = _mockDb[key];
        if (translations != null && translations.containsKey(targetLang)) {
          return translations[targetLang]!;
        }
      }
    }

    // Dynamic generator fallback
    if (targetLang == 'Hindi') {
      return 'अनुवादित: $text (हिंदी में)';
    } else if (targetLang == 'English') {
      return 'Translated: $text (in English)';
    } else if (targetLang == 'Tamil') {
      return 'மொழிபெயர்க்கப்பட்டது: $text (தமிழில்)';
    } else {
      return '[$targetLang] $text';
    }
  }

  bool detectCodeMixed(String text) {
    // Basic analysis for mixed English and Hindi/Regional scripts
    final hasEnglish = RegExp(r'[a-zA-Z]').hasMatch(text);
    final hasDevanagari = RegExp(r'[\u0900-\u097F]').hasMatch(text);
    return hasEnglish && hasDevanagari;
  }
}

final translationAgentProvider = Provider<TranslationAgent>((ref) {
  return TranslationAgent();
});
