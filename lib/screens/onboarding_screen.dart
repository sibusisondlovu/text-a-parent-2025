import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  static const String id = '/onboarding';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  void _navigateToNext(BuildContext context, String role) {
    Navigator.pushNamed(context, '/${role.toLowerCase()}Onboarding');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Welcome to Text-a-Parent',
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineLarge,
              ),
              const SizedBox(height: 20),
              Text(
                'A simple, secure way to connect schools and parents.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: 60),

              // Role buttons
              _buildRoleButton(context, theme, 'Parent'),
              const SizedBox(height: 20),
              _buildRoleButton(context, theme, 'Teacher'),
              const SizedBox(height: 20),
              _buildRoleButton(context, theme, 'School Admin'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleButton(BuildContext context, ThemeData theme, String role) {
    return ElevatedButton(
      onPressed: () => _navigateToNext(context, role),
      style: theme.elevatedButtonTheme.style,
      child: Text("I'm a $role"),
    );
  }
}
