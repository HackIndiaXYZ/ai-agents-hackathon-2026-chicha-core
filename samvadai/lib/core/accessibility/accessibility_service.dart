import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccessibilityState {
  final bool isVoiceFirstMode;
  final double fontSizeMultiplier;
  final bool isHighContrast;
  final bool isElderlyFriendly;

  const AccessibilityState({
    this.isVoiceFirstMode = false,
    this.fontSizeMultiplier = 1.0,
    this.isHighContrast = false,
    this.isElderlyFriendly = false,
  });

  AccessibilityState copyWith({
    bool? isVoiceFirstMode,
    double? fontSizeMultiplier,
    bool? isHighContrast,
    bool? isElderlyFriendly,
  }) {
    return AccessibilityState(
      isVoiceFirstMode: isVoiceFirstMode ?? this.isVoiceFirstMode,
      fontSizeMultiplier: fontSizeMultiplier ?? this.fontSizeMultiplier,
      isHighContrast: isHighContrast ?? this.isHighContrast,
      isElderlyFriendly: isElderlyFriendly ?? this.isElderlyFriendly,
    );
  }
}

class AccessibilityNotifier extends StateNotifier<AccessibilityState> {
  AccessibilityNotifier() : super(const AccessibilityState());

  void toggleVoiceFirstMode() {
    state = state.copyWith(isVoiceFirstMode: !state.isVoiceFirstMode);
  }

  void updateFontSize(double scale) {
    state = state.copyWith(fontSizeMultiplier: scale);
  }

  void toggleHighContrast() {
    state = state.copyWith(isHighContrast: !state.isHighContrast);
  }

  void toggleElderlyFriendly() {
    state = state.copyWith(
      isElderlyFriendly: !state.isElderlyFriendly,
      // Elderly-friendly defaults to larger text
      fontSizeMultiplier: !state.isElderlyFriendly ? 1.3 : 1.0,
      isVoiceFirstMode: !state.isElderlyFriendly,
    );
  }
}

final accessibilityProvider =
    StateNotifierProvider<AccessibilityNotifier, AccessibilityState>((ref) {
  return AccessibilityNotifier();
});
