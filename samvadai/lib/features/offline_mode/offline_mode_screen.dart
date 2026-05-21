import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../../agents/offline_agent/offline_agent.dart';

class OfflineModeScreen extends HookConsumerWidget {
  const OfflineModeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final emergencyResult = useState('');

    final languagePacks = ref.watch(offlineAgentProvider);
    final offlineAgentNotifier = ref.read(offlineAgentProvider.notifier);

    void searchPhrase() {
      if (searchController.text.trim().isEmpty) return;
      final result = offlineAgentNotifier.searchEmergencyPhrase(searchController.text);
      emergencyResult.value = result;
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundVoid,
      appBar: AppBar(
        title: const Text('Offline Mode'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Offline Status Card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.glowTeal,
                          ),
                          child: const Icon(Icons.cloud_done_rounded, color: AppColors.tealAccent, size: 28),
                        ),
                        const SizedBox(width: 16),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Local Model Synced',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text(
                                'Your offline dictionary and emergency packs are fully active.',
                                style: TextStyle(color: AppColors.greyText, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Emergency Phrase Search Card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Offline Emergency Dictionary',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: 'Enter emergency terms (e.g. dawai, doctor)...',
                            hintStyle: const TextStyle(color: AppColors.greyText),
                            filled: true,
                            fillColor: AppColors.backgroundVoid,
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.search_rounded, color: AppColors.tealAccent),
                              onPressed: searchPhrase,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          style: const TextStyle(color: AppColors.warmWhite),
                        ),
                        if (emergencyResult.value.isNotEmpty) ...[
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.tealAccent.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppColors.tealAccent),
                            ),
                            child: Text(
                              'Meaning: ${emergencyResult.value}',
                              style: const TextStyle(color: AppColors.tealAccent, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Language packs download manager list
                const Text(
                  'DOWNLOAD LINGUISTIC PACKS',
                  style: TextStyle(fontSize: 12, color: AppColors.greyText, fontWeight: FontWeight.bold, letterSpacing: 1.5),
                ),
                const SizedBox(height: 12),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: languagePacks.length,
                  itemBuilder: (context, index) {
                    final pack = languagePacks[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.greyCard,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.indigoPrimary),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                pack.languageName,
                                style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.warmWhite),
                              ),
                              Text(
                                '${pack.sizeMb.toStringAsFixed(1)} MB',
                                style: const TextStyle(color: AppColors.greyText, fontSize: 12),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              if (pack.downloadProgress > 0 && pack.downloadProgress < 1.0)
                                SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    value: pack.downloadProgress,
                                    color: AppColors.amberHighlight,
                                    strokeWidth: 3,
                                  ),
                                )
                              else if (pack.isDownloaded)
                                const Icon(Icons.check_circle_rounded, color: AppColors.tealAccent)
                              else
                                IconButton(
                                  icon: const Icon(Icons.download_for_offline_rounded, color: AppColors.violetAccent),
                                  onPressed: () => offlineAgentNotifier.downloadPack(pack.languageName),
                                ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
