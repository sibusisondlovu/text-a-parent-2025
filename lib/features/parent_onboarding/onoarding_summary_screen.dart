import 'package:flutter/material.dart';

class OnboardingSummaryScreen extends StatelessWidget {
  static const String id = '/onboarding-summary';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(title: const Text('Summary')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name: ${args['name']}"),
            Text("Phone: ${args['phone']}"),
            Text("Email: ${args['email']}"),
            Text("District: ${args['district']}"),
            Text("School: ${args['school']}"),
            Text("Child Code: ${args['childCode']}"),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
              Navigator.pushNamed(context, 'parentDashboard');
               // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Account created successfully')));
              },
              child: const Text('Finiskh'),
            ),
          ],
        ),
      ),
    );
  }
}
