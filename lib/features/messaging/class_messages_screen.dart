import 'package:flutter/material.dart';

class ClassMessagesScreen extends StatelessWidget {
  static const String id = '/classMessages';

  const ClassMessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final className = ModalRoute.of(context)!.settings.arguments as String;

    final List<Map<String, String>> mockMessages = [
      {'sender': 'Teacher', 'text': 'Welcome to the new term!'},
      {'sender': 'You', 'text': 'Thank you! Happy to be here.'},
      {'sender': 'Teacher', 'text': 'Homework due on Friday.'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(className),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: mockMessages.length,
        itemBuilder: (_, index) {
          final msg = mockMessages[index];
          final isFromParent = msg['sender'] == 'You';
          return Align(
            alignment: isFromParent ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color: isFromParent ? Colors.blue[100] : Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(msg['text']!),
            ),
          );
        },
      ),
    );
  }
}
