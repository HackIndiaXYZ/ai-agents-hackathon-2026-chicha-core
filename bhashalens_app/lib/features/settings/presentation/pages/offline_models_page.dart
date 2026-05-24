import 'package:flutter/material.dart';
import 'package:bhashalens_app/features/translation/data/services/ml_kit_translation_service.dart';
import 'package:bhashalens_app/features/translation/data/services/ct2_model_manager.dart';
import 'package:bhashalens_app/core/theme/app_colors.dart';

class OfflineModelsPage extends StatefulWidget {
  const OfflineModelsPage({super.key});

  @override
  State<OfflineModelsPage> createState() => _OfflineModelsPageState();
}

class _OfflineModelsPageState extends State<OfflineModelsPage> {
  final _mlKitService = MlKitTranslationService();
  final _ct2ModelManager = CT2ModelManager();
  
  final List<Map<String, String>> _supportedLanguages =
      MlKitTranslationService().getSupportedLanguages();

  // Track status of downloads: 'downloaded', 'downloading', 'not_downloaded', 'deleting'
  final Map<String, String> _modelStatus = {};
  final Map<String, double> _downloadProgress = {};

  // Track status of CTranslate2 packs
  final Map<String, String> _ct2PackStatus = {};
  final Map<String, double> _ct2DownloadProgress = {};

  bool _wifiOnly = true;
  int _activeTab = 0; // 0 for CTranslate2 Direct Regional, 1 for ML Kit Fallbacks

  // CTranslate2 packs
  static const List<Map<String, String>> _ct2Packs = [
    {
      'lang1': 'hi',
      'lang2': 'en',
      'name': 'Hindi ↔ English',
      'description': 'Direct bidirectional translation. Sub-200ms latency.',
      'size': '14.8 MB',
    },
    {
      'lang1': 'mr',
      'lang2': 'en',
      'name': 'Marathi ↔ English',
      'description': 'Direct bidirectional translation. Sub-200ms latency.',
      'size': '14.8 MB',
    },
    {
      'lang1': 'hi',
      'lang2': 'mr',
      'name': 'Hindi ↔ Marathi',
      'description': 'Direct bidirectional translation. Sub-200ms latency.',
      'size': '14.8 MB',
    },
  ];

  // Theme Colors - Mapped to the SamvadAI Brand Theme
  static const Color bgDark = AppColors.voidBg; // main background
  static const Color cardDark = AppColors.surfaceDark; // card background
  static const Color primaryBlue = AppColors.violetAccent; // Active Accent (Violet)
  static const Color textGrey = AppColors.slate400;
  static const Color dividerColor = AppColors.borderDark;

  @override
  void initState() {
    super.initState();
    _checkDownloadedModels();
  }

  Future<void> _checkDownloadedModels() async {
    // 1. Check ML Kit downloaded models
    final downloadedMlKit = await _mlKitService.getDownloadedModels();

    // 2. Check CTranslate2 packs
    final Map<String, String> localCt2Status = {};
    for (var pack in _ct2Packs) {
      final lang1 = pack['lang1']!;
      final lang2 = pack['lang2']!;
      final key = _ct2ModelManager.getPackKey(lang1, lang2);

      final isDownloaded = await _ct2ModelManager.isPackDownloaded(lang1, lang2);
      localCt2Status[key] = isDownloaded ? 'downloaded' : 'not_downloaded';
    }

    if (mounted) {
      setState(() {
        for (var lang in _supportedLanguages) {
          final code = lang['code']!;
          if (_modelStatus[code] != 'downloading') {
            _modelStatus[code] = 'not_downloaded';
          }
        }
        for (var code in downloadedMlKit) {
          _modelStatus[code] = 'downloaded';
        }

        for (var key in localCt2Status.keys) {
          if (_ct2PackStatus[key] != 'downloading') {
            _ct2PackStatus[key] = localCt2Status[key]!;
          }
        }
      });
    }

    // Verify ML Kit statuses again asynchronously
    for (var lang in _supportedLanguages) {
      final code = lang['code']!;
      final isDownloaded = await _mlKitService.isModelDownloaded(code);
      if (mounted) {
        setState(() {
          if (_modelStatus[code] != 'downloading') {
            _modelStatus[code] = isDownloaded ? 'downloaded' : 'not_downloaded';
          }
        });
      }
    }
  }

  // --- CTranslate2 Pack Actions ---

  Future<void> _downloadCT2Pack(String lang1, String lang2) async {
    final key = _ct2ModelManager.getPackKey(lang1, lang2);
    setState(() {
      _ct2PackStatus[key] = 'downloading';
      _ct2DownloadProgress[key] = 0.0;
    });

    final success = await _ct2ModelManager.downloadPack(
      lang1,
      lang2,
      onProgress: (progress) {
        if (mounted) {
          setState(() {
            _ct2DownloadProgress[key] = progress;
          });
        }
      },
    );

    if (mounted) {
      setState(() {
        _ct2PackStatus[key] = success ? 'downloaded' : 'not_downloaded';
        _ct2DownloadProgress.remove(key);
      });
      if (success) {
        _checkDownloadedModels();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle_rounded, color: Color(0xFF22C55E), size: 20),
                const SizedBox(width: 8),
                Text('Direct Regional Pack ($lang1 ↔ $lang2) installed successfully!'),
              ],
            ),
            backgroundColor: const Color(0xFF1E2530),
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to install direct regional pack'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _cancelCT2Download(String key) {
    setState(() {
      _ct2PackStatus[key] = 'not_downloaded';
      _ct2DownloadProgress.remove(key);
    });
  }

  Future<void> _deleteCT2Pack(String lang1, String lang2) async {
    final key = _ct2ModelManager.getPackKey(lang1, lang2);
    setState(() {
      _ct2PackStatus[key] = 'deleting';
    });

    final success = await _ct2ModelManager.deletePack(lang1, lang2);

    if (mounted) {
      setState(() {
        _ct2PackStatus[key] = success ? 'not_downloaded' : 'downloaded';
      });
      if (success) {
        _checkDownloadedModels();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.delete_sweep_rounded, color: Color(0xFFEF4444), size: 20),
                const SizedBox(width: 8),
                Text('Direct Regional Pack ($lang1 ↔ $lang2) deleted.'),
              ],
            ),
            backgroundColor: const Color(0xFF1E2530),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  // --- ML Kit Pack Actions ---

  Future<void> _downloadMlKitModel(String code) async {
    setState(() {
      _modelStatus[code] = 'downloading';
      _downloadProgress[code] = 0.0;
    });

    void simulateProgress() async {
      for (int i = 0; i <= 90; i += 10) {
        if (!mounted || _modelStatus[code] != 'downloading') break;
        await Future.delayed(const Duration(milliseconds: 100));
        if (mounted && _modelStatus[code] == 'downloading') {
          setState(() {
            _downloadProgress[code] = i / 100.0;
          });
        }
      }
    }

    simulateProgress();
    final success = await _mlKitService.downloadModel(code);

    if (mounted && _modelStatus[code] == 'downloading') {
      setState(() {
        _downloadProgress[code] = 1.0;
      });
      await Future.delayed(const Duration(milliseconds: 200));
      if (mounted) {
        setState(() {
          _modelStatus[code] = success ? 'downloaded' : 'not_downloaded';
          _downloadProgress.remove(code);
        });
        if (success) {
          _checkDownloadedModels();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Download failed'), backgroundColor: Colors.red),
          );
        }
      }
    }
  }

  void _cancelMlKitDownload(String code) {
    setState(() {
      _modelStatus[code] = 'not_downloaded';
      _downloadProgress.remove(code);
    });
  }

  Future<void> _deleteMlKitModel(String code) async {
    setState(() {
      _modelStatus[code] = 'deleting';
    });

    final success = await _mlKitService.deleteModel(code);

    if (mounted) {
      setState(() {
        _modelStatus[code] = success ? 'not_downloaded' : 'downloaded';
      });
      if (success) {
        _checkDownloadedModels();
      }
    }
  }

  // --- Helper Methods for Sizing and Rendering ---

  double _getMlKitModelSizeInMB(String code) {
    switch (code) {
      case 'hi': return 42.5;
      case 'ta': return 45.1;
      case 'bn': return 38.2;
      case 'mr': return 35.0;
      case 'te': return 41.8;
      case 'en': return 30.0;
      default: return 39.4;
    }
  }

  double _calculateTotalDownloadedSize() {
    double totalSize = 0.0;

    // Sum ML Kit models
    _modelStatus.forEach((code, status) {
      if (status == 'downloaded') {
        totalSize += _getMlKitModelSizeInMB(code);
      }
    });

    // Sum CTranslate2 packs
    for (var pack in _ct2Packs) {
      final key = _ct2ModelManager.getPackKey(pack['lang1']!, pack['lang2']!);
      if (_ct2PackStatus[key] == 'downloaded') {
        // A bidirectional pack contains both directions on disk: 14.78 * 2 = 29.56 MB
        totalSize += 29.56;
      }
    }

    return totalSize;
  }

  Color _getFlagColor(String code) {
    switch (code) {
      case 'hi': return const Color(0xFF6E432A);
      case 'ta': return const Color(0xFF29406B);
      case 'bn': return const Color(0xFF285C42);
      case 'mr': return const Color(0xFF6B3037);
      case 'te': return const Color(0xFF423B69);
      case 'en': return const Color(0xFF1F4E79);
      default: return const Color(0xFF4A5568);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double totalUsageMB = _calculateTotalDownloadedSize();
    const double maxStorageMB = 2048.0; // 2 GB
    final double progressRatio = (totalUsageMB / maxStorageMB).clamp(0.0, 1.0);
    final double availableSpaceMB = (maxStorageMB - totalUsageMB).clamp(0.0, maxStorageMB);

    return Scaffold(
      backgroundColor: bgDark,
      appBar: AppBar(
        title: const Text(
          'Offline Packs',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: bgDark,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: dividerColor, height: 1),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // "Why download offline?" Info card
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF142033),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF1A2A44)),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.bolt_rounded, color: Color(0xFFEAB308), size: 24),
                      SizedBox(width: 10),
                      Text(
                        'Direct offline models active',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Switched to an ultra-efficient CTranslate2 machine translation architecture. Packs are condensed to just 14.8MB per direction for direct bidirectional local translations.',
                    style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
                  ),
                ],
              ),
            ),

            // Storage Usage Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Storage Usage',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${totalUsageMB.toStringAsFixed(1)} MB / 2.0 GB',
                        style: TextStyle(
                          color: progressRatio > 0.0 ? primaryBlue : textGrey,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Stack(
                    children: [
                      Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: const Color(0xFF28313F),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: 6,
                        width: MediaQuery.of(context).size.width * 0.9 * progressRatio,
                        decoration: BoxDecoration(
                          color: primaryBlue,
                          borderRadius: BorderRadius.circular(3),
                          boxShadow: [
                            BoxShadow(
                              color: primaryBlue.withAlpha(128),
                              blurRadius: 4,
                              offset: const Offset(0, 1),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${(availableSpaceMB / 1024.0).toStringAsFixed(2)} GB Available on device',
                    style: const TextStyle(
                      color: textGrey,
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Divider(color: dividerColor, height: 1),
            ),

            // Curved Pill Custom Segmented Control
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color(0xFF19202A),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: dividerColor),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _activeTab = 0;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: _activeTab == 0 ? primaryBlue : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.bolt_rounded,
                                size: 16,
                                color: _activeTab == 0 ? Colors.white : textGrey,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Direct Regional',
                                style: TextStyle(
                                  color: _activeTab == 0 ? Colors.white : textGrey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _activeTab = 1;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: _activeTab == 1 ? primaryBlue : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.layers_rounded,
                                size: 16,
                                color: _activeTab == 1 ? Colors.white : textGrey,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'General Fallbacks',
                                style: TextStyle(
                                  color: _activeTab == 1 ? Colors.white : textGrey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Tab-specific Header description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_activeTab == 0) ...[
                    const Row(
                      children: [
                        Icon(Icons.bolt_rounded, color: Colors.orangeAccent, size: 18),
                        SizedBox(width: 6),
                        Text(
                          'CTranslate2 Local Packs',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Optimized sub-15MB distilled student models. Bypasses intermediate pivot layers for high-performance direct local translation under 200ms.',
                      style: TextStyle(color: textGrey, fontSize: 12, height: 1.4),
                    ),
                  ] else ...[
                    const Row(
                      children: [
                        Icon(Icons.translate_rounded, color: primaryBlue, size: 18),
                        SizedBox(width: 6),
                        Text(
                          'ML Kit Standard Models',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Universal offline translation packs. Standard non-custom language pairs route securely via intermediate English pivot translation.',
                      style: TextStyle(color: textGrey, fontSize: 12, height: 1.4),
                    ),
                  ],
                  const SizedBox(height: 16),
                ],
              ),
            ),

            // Dynamic Language Packs List based on active tab
            if (_activeTab == 0)
              ..._ct2Packs.map((pack) {
                final l1 = pack['lang1']!;
                final l2 = pack['lang2']!;
                final name = pack['name']!;
                final key = _ct2ModelManager.getPackKey(l1, l2);
                final status = _ct2PackStatus[key] ?? 'not_downloaded';
                final progress = _ct2DownloadProgress[key] ?? 0.0;

                return Container(
                  margin: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
                  decoration: BoxDecoration(
                    color: cardDark,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: status == 'downloaded' ? primaryBlue.withAlpha(76) : Colors.transparent,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        // Dual Flag Simulation Circle
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: _getFlagColor(l1).withAlpha(204),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.bolt_rounded,
                              color: status == 'downloaded' ? Colors.orangeAccent : Colors.white70,
                              size: 24,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),

                        // Title & Subtitle
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              if (status == 'downloading')
                                Row(
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(2),
                                        child: LinearProgressIndicator(
                                          value: progress,
                                          backgroundColor: dividerColor,
                                          valueColor: const AlwaysStoppedAnimation<Color>(primaryBlue),
                                          minHeight: 4,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      '${(progress * 100).toInt()}%',
                                      style: const TextStyle(
                                        color: primaryBlue,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                )
                              else
                                Text(
                                  status == 'downloaded' ? '14.8 MB • Downloaded' : '14.8 MB • Offline Direct',
                                  style: TextStyle(
                                    color: status == 'downloaded' ? const Color(0xFF22C55E) : textGrey,
                                    fontSize: 12,
                                  ),
                                ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 16),
                        _buildCT2Action(l1, l2, status),
                      ],
                    ),
                  ),
                );
              })
            else
              ..._supportedLanguages.map((lang) {
                final code = lang['code']!;
                final name = lang['name']!;
                final status = _modelStatus[code] ?? 'not_downloaded';
                final size = '${_getMlKitModelSizeInMB(code).toStringAsFixed(1)} MB';
                final progress = _downloadProgress[code] ?? 0.0;
                final flagColor = _getFlagColor(code);

                return Container(
                  margin: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
                  decoration: BoxDecoration(
                    color: cardDark,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        // Flag Icon
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: flagColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.flag_rounded,
                            color: Colors.white70,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 16),
                        
                        // Title & Subtitle
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              if (status == 'downloading')
                                Row(
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(2),
                                        child: LinearProgressIndicator(
                                          value: progress,
                                          backgroundColor: dividerColor,
                                          valueColor: const AlwaysStoppedAnimation<Color>(primaryBlue),
                                          minHeight: 4,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      '${(progress * 100).toInt()}%',
                                      style: const TextStyle(
                                        color: primaryBlue,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                )
                              else
                                Text(
                                  status == 'downloaded' ? '$size • Downloaded' : size,
                                  style: const TextStyle(
                                    color: textGrey,
                                    fontSize: 12,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(width: 16),
                        _buildMlKitAction(code, status),
                      ],
                    ),
                  ),
                );
              }),
            
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Divider(color: dividerColor, height: 1),
            ),
            
            // Wi-Fi Only Switch
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Wi-Fi Only Downloads',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Save mobile data by downloading only on Wi-Fi',
                          style: TextStyle(
                            color: textGrey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: _wifiOnly,
                    onChanged: (val) {
                      setState(() {
                        _wifiOnly = val;
                      });
                    },
                    activeThumbColor: Colors.white,
                    activeTrackColor: primaryBlue,
                    inactiveThumbColor: textGrey,
                    inactiveTrackColor: dividerColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Actions Builders ---

  Widget _buildCT2Action(String l1, String l2, String status) {
    final key = _ct2ModelManager.getPackKey(l1, l2);
    if (status == 'downloading') {
      return SizedBox(
        width: 44,
        height: 44,
        child: Center(
          child: IconButton(
            icon: const Icon(Icons.close, color: textGrey, size: 24),
            onPressed: () => _cancelCT2Download(key),
            padding: EdgeInsets.zero,
            splashRadius: 24,
          ),
        ),
      );
    } else if (status == 'downloaded') {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.check_circle,
            color: Color(0xFF22C55E), 
            size: 22,
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 44,
            height: 44,
            child: IconButton(
              icon: const Icon(Icons.delete_outline, color: Color(0xFFEF4444), size: 22),
              onPressed: () => _deleteCT2Pack(l1, l2),
              padding: EdgeInsets.zero,
              splashRadius: 24,
            ),
          ),
        ],
      );
    } else if (status == 'deleting') {
      return const SizedBox(
        width: 44,
        height: 44,
        child: Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFFEF4444)),
          ),
        ),
      );
    } else {
      return SizedBox(
        width: 44,
        height: 44,
        child: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: primaryBlue, width: 1.5),
            ),
            child: const Icon(
              Icons.download_rounded,
              color: primaryBlue,
              size: 18,
            ),
          ),
          onPressed: () => _downloadCT2Pack(l1, l2),
          padding: EdgeInsets.zero,
          splashRadius: 24,
        ),
      );
    }
  }

  Widget _buildMlKitAction(String code, String status) {
    if (status == 'downloading') {
      return SizedBox(
        width: 44,
        height: 44,
        child: Center(
          child: IconButton(
            icon: const Icon(Icons.close, color: textGrey, size: 24),
            onPressed: () => _cancelMlKitDownload(code),
            padding: EdgeInsets.zero,
            splashRadius: 24,
          ),
        ),
      );
    } else if (status == 'downloaded') {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.check_circle,
            color: Color(0xFF22C55E), 
            size: 22,
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 44,
            height: 44,
            child: IconButton(
              icon: const Icon(Icons.delete_outline, color: Color(0xFFEF4444), size: 22),
              onPressed: () => _deleteMlKitModel(code),
              padding: EdgeInsets.zero,
              splashRadius: 24,
            ),
          ),
        ],
      );
    } else if (status == 'deleting') {
      return const SizedBox(
        width: 44,
        height: 44,
        child: Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFFEF4444)),
          ),
        ),
      );
    } else {
      return SizedBox(
        width: 44,
        height: 44,
        child: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: primaryBlue, width: 1.5),
            ),
            child: const Icon(
              Icons.download_rounded,
              color: primaryBlue,
              size: 18,
            ),
          ),
          onPressed: () => _downloadMlKitModel(code),
          padding: EdgeInsets.zero,
          splashRadius: 24,
        ),
      );
    }
  }
}
