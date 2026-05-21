import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundVoid,
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Visual Profile Details Card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.indigoPrimary,
                          ),
                          child: const Icon(Icons.face_retouching_natural_rounded, color: AppColors.violetAccent, size: 40),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Ismail Sayyed',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Text(
                          'Linguistic Level: Fluent',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.tealAccent,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Language selection configurations
                const Text(
                  'LANGUAGE PREFERENCES',
                  style: TextStyle(fontSize: 12, color: AppColors.greyText, fontWeight: FontWeight.bold, letterSpacing: 1.5),
                ),
                const SizedBox(height: 12),
                
                _buildOptionItem(
                  icon: Icons.language_rounded,
                  title: 'Primary Language',
                  value: 'Hindi (हिंदी)',
                  color: AppColors.violetAccent,
                ),
                _buildOptionItem(
                  icon: Icons.translate_rounded,
                  title: 'Default Translation Target',
                  value: 'English',
                  color: AppColors.tealAccent,
                ),
                const SizedBox(height: 24),

                // Statistics Card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Conversation Analytics',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Weekly Translations Done:', style: TextStyle(color: AppColors.greyText)),
                            Text('148', style: TextStyle(color: AppColors.warmWhite, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Accent Alignment Accuracy:', style: TextStyle(color: AppColors.greyText)),
                            Text('94.6%', style: TextStyle(color: AppColors.tealAccent, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Graphical representation indicator bar
                        Row(
                          children: [
                            Expanded(
                              flex: 7,
                              child: Container(
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: AppColors.tealAccent,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4),
                                    bottomLeft: Radius.circular(4),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: AppColors.violetAccent,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(4),
                                    bottomRight: Radius.circular(4),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionItem({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.greyCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.indigoPrimary),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.warmWhite, fontSize: 12),
                ),
                Text(
                  value,
                  style: const TextStyle(color: AppColors.greyText, fontSize: 14),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios_rounded, color: AppColors.greyText, size: 14),
        ],
      ),
    );
  }
}
