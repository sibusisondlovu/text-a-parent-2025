import 'package:flutter/material.dart';

import '../features/messaging/class_messages_screen.dart';

class ParentDashboardScreen extends StatelessWidget {
  static const String id = 'parentDashboard';

  final List<Map<String, dynamic>> mockClasses = [
    {
      'name': 'Grade 1 - Miss Sarah',
      'lastMessage': 'Reminder: Bring art supplies tomorrow.',
      'unread': true,
    },
    {
      'name': 'Grade 3 - Mr. Mokoena',
      'lastMessage': 'Homework due on Friday.',
      'unread': false,
    },
  ];

  ParentDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Classes'),
      ),
      body: ListView.builder(
        itemCount: mockClasses.length,
        itemBuilder: (_, index) {
          final classroom = mockClasses[index];
          return ListTile(
            title: Text(classroom['name']),
            subtitle: Text(classroom['lastMessage']),
            trailing: classroom['unread'] ? const Icon(Icons.mark_email_unread, color: Colors.red) : null,
            onTap: () {
              Navigator.pushNamed(
                context,
                ClassMessagesScreen.id,
                arguments: classroom['name'],
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Show modal or screen for sending message
          _showSendMessageDialog(context);
        },
        icon: const Icon(Icons.message),
        label: const Text('Send Message'),
      ),
    );
  }

  void _showSendMessageDialog(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('New Message to Teacher'),
        content: TextField(
          controller: _controller,
          maxLines: 3,
          decoration: const InputDecoration(hintText: 'Type your message...'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              // Send message logic here
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Message sent.')));
            },
            child: const Text('Send'),
          ),
        ],
      ),
    );
  }
}
