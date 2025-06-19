import 'package:flutter/material.dart';

class AdminOnboardingScreen extends StatelessWidget {
  static const String id = '/adminOnboarding';

  const AdminOnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Onboarding')),
      body: const Center(child: Text('Admin setup coming soon...')),
    );
  }
}
