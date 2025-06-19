import 'package:flutter/material.dart';

class OnboardingPageContent extends StatelessWidget {
  final String title;
  final String description;
  final String imageAsset;

  const OnboardingPageContent({
    super.key,
    required this.title,
    required this.description,
    required this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imageAsset, height: 250),
          const SizedBox(height: 32),
          Text(
            title,
            style: theme.textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: theme.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
