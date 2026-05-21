import 'package:flutter_riverpod/flutter_riverpod.dart';

class LanguagePack {
  final String languageName;
  final double sizeMb;
  final bool isDownloaded;
  final double downloadProgress; // 0.0 to 1.0

  LanguagePack({
    required this.languageName,
    required this.sizeMb,
    this.isDownloaded = false,
    this.downloadProgress = 0.0,
  });

  LanguagePack copyWith({
    bool? isDownloaded,
    double? downloadProgress,
  }) {
    return LanguagePack(
      languageName: languageName,
      sizeMb: sizeMb,
      isDownloaded: isDownloaded ?? this.isDownloaded,
      downloadProgress: downloadProgress ?? this.downloadProgress,
    );
  }
}

class OfflineAgentNotifier extends StateNotifier<List<LanguagePack>> {
  OfflineAgentNotifier()
      : super([
          LanguagePack(languageName: 'Hindi', sizeMb: 42.5, isDownloaded: true, downloadProgress: 1.0),
          LanguagePack(languageName: 'Tamil', sizeMb: 38.0, isDownloaded: false, downloadProgress: 0.0),
          LanguagePack(languageName: 'Marathi', sizeMb: 35.2, isDownloaded: false, downloadProgress: 0.0),
          LanguagePack(languageName: 'Telugu', sizeMb: 39.1, isDownloaded: false, downloadProgress: 0.0),
          LanguagePack(languageName: 'Bengali', sizeMb: 41.3, isDownloaded: false, downloadProgress: 0.0),
        ]);

  // Simulated download process
  Future<void> downloadPack(String langName) async {
    state = [
      for (var pack in state)
        if (pack.languageName == langName) pack.copyWith(downloadProgress: 0.1) else pack
    ];

    for (int i = 2; i <= 10; i++) {
      await Future.delayed(const Duration(milliseconds: 300));
      state = [
        for (var pack in state)
          if (pack.languageName == langName)
            pack.copyWith(
              downloadProgress: i * 0.1,
              isDownloaded: i == 10,
            )
          else
            pack
      ];
    }
  }

  // Emergency local phrases lookup database
  final Map<String, String> _emergencyPhrases = {
    'dawai': 'Medicine',
    'hospital': 'Hospital',
    'doctor': 'Doctor',
    'police': 'Police',
    'help': 'Bachao / Sahayata',
  };

  String searchEmergencyPhrase(String phrase) {
    final lower = phrase.toLowerCase();
    return _emergencyPhrases[lower] ?? 'Phrase not found in emergency dictionary';
  }
}

final offlineAgentProvider =
    StateNotifierProvider<OfflineAgentNotifier, List<LanguagePack>>((ref) {
  return OfflineAgentNotifier();
});
