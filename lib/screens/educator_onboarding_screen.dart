import 'package:flutter/material.dart';

class EducatorOnboardingScreen extends StatelessWidget {
  static const String id = '/educatorOnboarding';

  const EducatorOnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Educator Onboarding')),
      body: const Center(child: Text('Educator setup coming soon...')),
    );
  }
}
