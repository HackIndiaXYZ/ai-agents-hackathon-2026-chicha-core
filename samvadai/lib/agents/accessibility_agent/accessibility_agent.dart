import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccessibilityAgent {
  String getElderlyModeGuide() {
    return 'Voice assistance activated. Tap anywhere to speak, double-tap to repeat the translated text.';
  }

  String getLowLiteracyInstruction() {
    return 'Visual prompts enabled. Touch the microphone to record your message.';
  }

  double getOptimalButtonHeight(bool isElderlyFriendly) {
    return isElderlyFriendly ? 84.0 : 56.0;
  }

  double getOptimalFontSize(bool isElderlyFriendly, double baseSize) {
    return isElderlyFriendly ? baseSize * 1.35 : baseSize;
  }
}

final accessibilityAgentProvider = Provider<AccessibilityAgent>((ref) {
  return AccessibilityAgent();
});
