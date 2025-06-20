import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:fluttertoast/fluttertoast.dart';

class ParentDashboardScreen extends StatefulWidget {
  static const String id = 'parentDashboard';

  final bool showSuccess;

  const ParentDashboardScreen({super.key, this.showSuccess = false});

  @override
  State<ParentDashboardScreen> createState() => _ParentDashboardScreenState();
}

class _ParentDashboardScreenState extends State<ParentDashboardScreen> {

  @override
  void initState() {
    super.initState();
  }

  void _openDrawer() {
    Scaffold.of(context).openDrawer();
  }

  String _formatTimestamp(Timestamp timestamp) {
    final date = timestamp.toDate();
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  void _onFabPressed() {
    // You can show a modal or navigation here to create new diary/message
    showModalBottomSheet(
      context: context,
      builder: (_) => ListView(
        shrinkWrap: true,
        children: [
          ListTile(
            leading: const Icon(Icons.message),
            title: const Text('Message Teacher'),
            onTap: () {
              Navigator.pop(context);
              // Navigate or show form
            },
          ),
          ListTile(
            leading: const Icon(Icons.edit_note),
            title: const Text('Write Diary Entry'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context,'writeDiary' );
              // Navigate or show form
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final currentUser = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Diary Inbox"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text("Welcome, Parent", style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                // Navigate to profile
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Navigate to settings
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                // Handle logout
              },
            ),
          ],
        ),
      ),
      body: _diaryEntries(context),
      floatingActionButton: FloatingActionButton(
        onPressed: _onFabPressed,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _diaryEntries(BuildContext ctx) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('diary_entries')
          .where('parentId')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final entries = snapshot.data!.docs;

        if (entries.isEmpty) {
          return const Center(child: Text('No diary entries yet.'));
        }

        return ListView.builder(
          itemCount: entries.length,
          itemBuilder: (context, index) {
            final entry = entries[index];
            final isFromTeacher = entry['sender'] == 'teacher';
            final isRead = isFromTeacher
                ? entry['isReadByParent']
                : entry['isReadByTeacher'];
            final readAt = isFromTeacher
                ? entry['readByParentAt']
                : entry['readByTeacherAt'];

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: isFromTeacher ? Colors.blue : Colors.green,
                  child: Icon(isFromTeacher ? Icons.school : Icons.person, color: Colors.white),
                ),
                title: Text(
                  entry['title'] ?? 'No Title',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      entry['content'].length > 70
                          ? '${entry['content'].substring(0, 70)}...'
                          : entry['content'],
                      style: const TextStyle(color: Colors.black87),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      isFromTeacher ? 'From: Teacher' : 'From: You',
                      style: TextStyle(
                        color: isFromTeacher ? Colors.blue : Colors.green,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text('Sent: ${_formatTimestamp(entry['timestamp'])}'),
                    if (isRead && readAt != null)
                      Text(
                        'Read at: ${_formatTimestamp(readAt)}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                  ],
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                onTap: () {

                },
              ),
            );

          },
        );
      },
    );
  }
}
