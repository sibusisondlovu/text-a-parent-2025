import 'package:flutter/material.dart';

import 'onoarding_summary_screen.dart';

class CreateParentAccountScreen extends StatelessWidget {
  static const String id = '/create-parent';

  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(title: const Text('Create Account')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(controller: name, decoration: const InputDecoration(labelText: 'Full Name')),
            TextField(controller: phone, decoration: const InputDecoration(labelText: 'Phone')),
            TextField(controller: email, decoration: const InputDecoration(labelText: 'Email')),
            TextField(controller: password, obscureText: true, decoration: const InputDecoration(labelText: 'Password')),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, OnboardingSummaryScreen.id, arguments: {
                  ...args,
                  'name': name.text,
                  'phone': phone.text,
                  'email': email.text,
                });
              },
              child: const Text('Create Account'),
            ),
          ],
        ),
      ),
    );
  }
}
