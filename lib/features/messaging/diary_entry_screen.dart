import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DiaryEntryScreen extends StatefulWidget {
  static const String id = 'writeDiary';

  const DiaryEntryScreen({super.key});

  @override
  State<DiaryEntryScreen> createState() => _DiaryEntryScreenState();
}

class _DiaryEntryScreenState extends State<DiaryEntryScreen> {
  final TextEditingController _entryController = TextEditingController();
  bool isLoading = false;

  Future<void> _submitEntry() async {
    final content = _entryController.text.trim();
    if (content.isEmpty) return;

    setState(() => isLoading = true);

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception('User not logged in');

      final now = Timestamp.now();

      await FirebaseFirestore.instance.collection('diary_entries').add({
        'parentId': user.uid,
        'teacherId': 'teacher123',
        'title': content.length > 30 ? content.substring(0, 30) + '...' : content,
        'content': content,
        'sender': 'parent',
        'isReadByParent': true,
        'isReadByTeacher': false,
        'readByParentAt': now,
        'readByTeacherAt': null,
        'timestamp': now,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Diary entry sent!')),
      );

      Navigator.pop(context); // Go back to dashboard
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }



  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Write Diary Entry')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text(
              'Write a note to your child\'s teacher',
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: TextField(
                controller: _entryController,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: const InputDecoration(
                  hintText: 'Enter your message here...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton.icon(
              onPressed: _submitEntry,
              icon: const Icon(Icons.send),
              label: const Text('Send Entry'),
            ),
          ],
        ),
      ),
    );
  }
}
