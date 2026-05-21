import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundVoid,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Profile bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SamvadAI',
                          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                color: AppColors.warmWhite,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.tealAccent,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '3 Agents Active',
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: AppColors.tealAccent,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.accessibility_new_rounded, color: AppColors.violetAccent, size: 28),
                      onPressed: () => context.push('/accessibility-center'),
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                // Quick translate card
                GestureDetector(
                  onTap: () => context.go('/translate'),
                  child: Card(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: LinearGradient(
                          colors: [AppColors.indigoPrimary.withValues(alpha: 0.6), AppColors.violetAccent.withValues(alpha: 0.1)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.translate_rounded, color: AppColors.violetAccent, size: 36),
                              Icon(Icons.arrow_forward_ios_rounded, color: AppColors.greyText, size: 16),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Quick Text Translation',
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Type text or paste and get instant context-aware translation in 22 regional languages.',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Voice Translation Button card
                GestureDetector(
                  onTap: () => context.go('/voice'),
                  child: Card(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: LinearGradient(
                          colors: [AppColors.indigoPrimary.withValues(alpha: 0.6), AppColors.amberHighlight.withValues(alpha: 0.1)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.glowAmber,
                            ),
                            child: const Icon(Icons.spatial_audio_off_rounded, color: AppColors.amberHighlight, size: 32),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Voice-to-Voice Translate',
                                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Speak and listen to translation instantly.',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                // Active AI Agents Section
                Text(
                  'ACTIVE LINGUISTIC AGENTS',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppColors.greyText,
                        letterSpacing: 1.5,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 36,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      _buildAgentChip('Translation Agent', AppColors.tealAccent),
                      _buildAgentChip('Speech Synth Agent', AppColors.amberHighlight),
                      _buildAgentChip('Context Mapping Agent', AppColors.violetAccent),
                      _buildAgentChip('Offline Inferences Agent', AppColors.greyText),
                    ],
                  ),
                ),
                const SizedBox(height: 28),

                // Quick Mode Gate Cards (Offline and Adaptive Learning)
                Row(
                  children: [
                    Expanded(
                      child: _buildFeatureCard(
                        context,
                        'Offline Mode',
                        'Get pack status and dictionary lookup.',
                        Icons.signal_wifi_off_rounded,
                        AppColors.tealAccent,
                        '/offline',
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildFeatureCard(
                        context,
                        'Adaptive AI',
                        'View corrections and intelligence curves.',
                        Icons.insights_rounded,
                        AppColors.amberHighlight,
                        '/adaptive-learning',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAgentChip(String name, Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.indigoPrimary.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          ),
          const SizedBox(width: 8),
          Text(
            name,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColors.warmWhite,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    Color color,
    String route,
  ) {
    return GestureDetector(
      onTap: () => context.push(route),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(height: 16),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 6),
              Text(
                description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 12,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
