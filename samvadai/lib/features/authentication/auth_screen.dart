import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/widgets/glowing_button.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  bool _otpSent = false;

  void _handleAuth() {
    // Simulated authentication process
    if (!_otpSent) {
      if (_phoneController.text.length >= 10) {
        setState(() {
          _otpSent = true;
        });
      }
    } else {
      if (_otpController.text.length == 6 || _otpController.text == '123456') {
        context.go('/home');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundVoid,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  'Verify Your Identity',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: Text(
                  'Choose how you want to access regional intelligence',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(height: 48),

              // Dynamic Phone Input or OTP Input Card
              Card(
                color: AppColors.greyCard,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        _otpSent ? 'Enter 6-digit OTP' : 'Login via Mobile Number',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 16),
                      if (!_otpSent)
                        TextField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: 'Enter 10-digit number',
                            hintStyle: const TextStyle(color: AppColors.greyText),
                            prefixText: '+91 ',
                            prefixStyle: const TextStyle(color: AppColors.warmWhite),
                            filled: true,
                            fillColor: AppColors.backgroundVoid,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          style: const TextStyle(color: AppColors.warmWhite),
                        )
                      else
                        TextField(
                          controller: _otpController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Enter OTP (e.g. 123456)',
                            hintStyle: const TextStyle(color: AppColors.greyText),
                            filled: true,
                            fillColor: AppColors.backgroundVoid,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          style: const TextStyle(color: AppColors.warmWhite),
                        ),
                      const SizedBox(height: 24),
                      GlowingButton(
                        text: _otpSent ? 'Verify & Continue' : 'Get OTP',
                        onPressed: _handleAuth,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 36),

              // Alternative choices separator
              const Row(
                children: [
                  Expanded(child: Divider(color: AppColors.indigoPrimary)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('OR', style: TextStyle(color: AppColors.greyText)),
                  ),
                  Expanded(child: Divider(color: AppColors.indigoPrimary)),
                ],
              ),
              const SizedBox(height: 36),

              // Third-party buttons
              OutlinedButton.icon(
                onPressed: () => context.go('/home'),
                icon: const Icon(Icons.g_mobiledata_rounded, color: AppColors.violetAccent, size: 28),
                label: const Text('Continue with Google'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.warmWhite,
                  side: const BorderSide(color: AppColors.indigoPrimary, width: 1.5),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              TextButton(
                onPressed: () => context.go('/home'),
                child: Text(
                  'Access App as Guest',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppColors.tealAccent,
                        decoration: TextDecoration.underline,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
