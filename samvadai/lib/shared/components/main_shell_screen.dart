import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';

class MainShellScreen extends StatelessWidget {
  final Widget child;

  const MainShellScreen({super.key, required this.child});

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/translate')) return 1;
    if (location.startsWith('/voice')) return 2;
    if (location.startsWith('/assistant')) return 3;
    if (location.startsWith('/profile')) return 4;
    return 0; // Default /home
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go('/home');
        break;
      case 1:
        GoRouter.of(context).go('/translate');
        break;
      case 2:
        GoRouter.of(context).go('/voice');
        break;
      case 3:
        GoRouter.of(context).go('/assistant');
        break;
      case 4:
        GoRouter.of(context).go('/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _calculateSelectedIndex(context);

    return Scaffold(
      body: child,
      // Premium floating design
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: const BoxDecoration(
          color: AppColors.backgroundVoid,
          border: Border(
            top: BorderSide(color: AppColors.indigoPrimary, width: 1.5),
          ),
        ),
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.greyCard,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: AppColors.glowViolet.withValues(alpha: 0.1),
                  blurRadius: 20,
                  spreadRadius: 1,
                  offset: const Offset(0, -2),
                ),
              ],
              border: Border.all(
                color: AppColors.indigoPrimary,
                width: 1.5,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(context, 0, Icons.home_filled, 'Home', selectedIndex),
                  _buildNavItem(context, 1, Icons.translate_rounded, 'Translate', selectedIndex),
                  _buildNavItem(context, 2, Icons.spatial_audio_off_rounded, 'Voice', selectedIndex),
                  _buildNavItem(context, 3, Icons.bolt_rounded, 'AI Assistant', selectedIndex),
                  _buildNavItem(context, 4, Icons.person_rounded, 'Profile', selectedIndex),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    int index,
    IconData icon,
    String label,
    int selectedIndex,
  ) {
    final isSelected = index == selectedIndex;
    final activeColor = index == 2
        ? AppColors.amberHighlight
        : (index == 3 ? AppColors.violetAccent : AppColors.tealAccent);

    return GestureDetector(
      onTap: () => _onItemTapped(index, context),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? activeColor.withValues(alpha: 0.15) : Colors.transparent,
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: activeColor.withValues(alpha: 0.2),
                        blurRadius: 10,
                        spreadRadius: 1,
                      )
                    ]
                  : null,
            ),
            child: Icon(
              icon,
              color: isSelected ? activeColor : AppColors.greyText,
              size: 24,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: isSelected ? activeColor : AppColors.greyText,
                  fontSize: 10,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
          ),
        ],
      ),
    );
  }
}
