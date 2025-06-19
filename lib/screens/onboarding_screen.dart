import 'package:flutter/material.dart';

import 'admin_onboarding.dart';
import 'educator_onboarding_screen.dart';
import 'parent_onboarding_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({
    super.key,
    required this.title,
    required this.description,
    required this.imageAsset,
  });

  static const String id = '/onboarding';

  final String title;
  final String description;
  final String imageAsset;

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  void _navigateToNext(BuildContext context, String role) {
    switch (role.toLowerCase()) {
      case 'parent':
        Navigator.pushNamed(context, ParentOnboardingScreen.id);
        break;
      case 'teacher':
        Navigator.pushNamed(context, EducatorOnboardingScreen.id);
        break;
      case 'school admin':
        Navigator.pushNamed(context, AdminOnboardingScreen.id);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(widget.imageAsset, height: 250),
            const SizedBox(height: 32),
            Text(
              widget.title,
              style: theme.textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              widget.description,
              style: theme.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            _buildRoleButton(context, theme, 'Parent'),
            const SizedBox(height: 16),
            _buildRoleButton(context, theme, 'Teacher'),
            const SizedBox(height: 16),
            _buildRoleButton(context, theme, 'School Admin'),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleButton(BuildContext context, ThemeData theme, String role) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => _navigateToNext(context, role),
        style: theme.elevatedButtonTheme.style,
        child: Text("I'm a $role"),
      ),
    );
  }
}
