import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class TranslationBubble extends StatelessWidget {
  final String text;
  final String translation;
  final String sourceLanguage;
  final String targetLanguage;
  final bool isUser;

  const TranslationBubble({
    super.key,
    required this.text,
    required this.translation,
    required this.sourceLanguage,
    required this.targetLanguage,
    required this.isUser,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: isUser ? AppColors.indigoPrimary.withValues(alpha: 0.8) : AppColors.tealAccent.withValues(alpha: 0.2),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: Radius.circular(isUser ? 20 : 0),
            bottomRight: Radius.circular(isUser ? 0 : 20),
          ),
          border: Border.all(
            color: isUser ? AppColors.violetAccent.withValues(alpha: 0.3) : AppColors.tealAccent.withValues(alpha: 0.4),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Target Translation (Primary focus)
            Text(
              translation,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.warmWhite,
                  ),
            ),
            const SizedBox(height: 6),
            // Source text
            Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.greyText,
                    fontStyle: FontStyle.italic,
                  ),
            ),
            const SizedBox(height: 8),
            // Active Tag indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$sourceLanguage ➔ $targetLanguage',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: isUser ? AppColors.violetAccent : AppColors.tealAccent,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Icon(
                  Icons.volume_up,
                  size: 14,
                  color: isUser ? AppColors.violetAccent : AppColors.tealAccent,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
