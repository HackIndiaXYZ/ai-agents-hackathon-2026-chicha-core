import 'package:flutter/material.dart';
import 'package:bhashalens_app/core/theme/app_colors.dart';

class CommonBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const CommonBottomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => _onItemTapped(context, index),
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.voidBg,
      selectedItemColor: AppColors.violetAccent,
      unselectedItemColor: AppColors.slate400,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.translate),
          label: 'Translate',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.description),
          label: 'Explain',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Records'),
        BottomNavigationBarItem(
          icon: Icon(Icons.smart_toy),
          label: 'Assistant',
        ),
      ],
    );
  }

  void _onItemTapped(BuildContext context, int index) {
    if (index == currentIndex) return;

    final routes = [
      '/home',
      '/translation_mode',
      '/explain_mode',
      '/history_saved',
      '/assistant_mode',
    ];

    Navigator.pushReplacementNamed(context, routes[index]);
  }
}
