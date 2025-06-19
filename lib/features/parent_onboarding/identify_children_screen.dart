import 'package:flutter/material.dart';

import 'create_parent_account_screen.dart';

class IdentifyChildScreen extends StatelessWidget {
  static const String id = '/identify-child';

  final TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final school = args['school'];

    return Scaffold(
      appBar: AppBar(title: const Text('Identify Your Child')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text('Enter the child code given by $school'),
            const SizedBox(height: 16),
            TextField(controller: codeController, decoration: const InputDecoration(labelText: 'Child Code')),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  CreateParentAccountScreen.id,
                  arguments: {
                    ...args,
                    'childCode': codeController.text,
                  },
                );
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
