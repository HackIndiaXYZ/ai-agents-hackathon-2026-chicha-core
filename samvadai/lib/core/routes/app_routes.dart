import 'package:go_router/go_router.dart';
import '../../features/splash/splash_screen.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/authentication/auth_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/translation/translation_screen.dart';
import '../../features/voice_translation/voice_translation_screen.dart';
import '../../features/ai_assistant/ai_assistant_screen.dart';
import '../../features/profile/profile_screen.dart';
import '../../features/offline_mode/offline_mode_screen.dart';
import '../../features/adaptive_learning/adaptive_learning_screen.dart';
import '../../features/accessibility_center/accessibility_center_screen.dart';
import '../../shared/components/main_shell_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String auth = '/auth';
  static const String home = '/home';
  static const String translate = '/translate';
  static const String voice = '/voice';
  static const String assistant = '/assistant';
  static const String profile = '/profile';
  static const String offlineMode = '/offline';
  static const String adaptiveLearning = '/adaptive-learning';
  static const String accessibilityCenter = '/accessibility-center';

  static final GoRouter router = GoRouter(
    initialLocation: splash,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: auth,
        builder: (context, state) => const AuthScreen(),
      ),
      // Shell route for Bottom Navigation
      ShellRoute(
        builder: (context, state, child) => MainShellScreen(child: child),
        routes: [
          GoRoute(
            path: home,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HomeScreen(),
            ),
          ),
          GoRoute(
            path: translate,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: TranslationScreen(),
            ),
          ),
          GoRoute(
            path: voice,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: VoiceTranslationScreen(),
            ),
          ),
          GoRoute(
            path: assistant,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: AiAssistantScreen(),
            ),
          ),
          GoRoute(
            path: profile,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ProfileScreen(),
            ),
          ),
        ],
      ),
      // Sub-routes outside shell
      GoRoute(
        path: offlineMode,
        builder: (context, state) => const OfflineModeScreen(),
      ),
      GoRoute(
        path: adaptiveLearning,
        builder: (context, state) => const AdaptiveLearningScreen(),
      ),
      GoRoute(
        path: accessibilityCenter,
        builder: (context, state) => const AccessibilityCenterScreen(),
      ),
    ],
  );
}
