import 'package:flutter/material.dart';

import '../components/app_drawer.dart';
import '../utils/theme.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data for newsletters and notices
    final newsletters = [
      {"title": "Newsletter 1", "summary": "This is the first newsletter"},
      {"title": "Newsletter 2", "summary": "This is the second newsletter"},
      {"title": "Newsletter 3", "summary": "This is the third newsletter"},
    ];

    final notices = [
      {"title": "Notice 1", "summary": "Parent-teacher meeting on Friday"},
      {"title": "Notice 2", "summary": "School closed next Monday"},
    ];

    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("Text-a-Parent"),
        backgroundColor: AppTheme.lightTheme.primaryColor,
        elevation: 0,
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting
            const Text(
              "Hello, Parent 👋",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Latest Notices
            const Text(
              "Latest Notices",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: notices.length,
                itemBuilder: (context, index) {
                  final notice = notices[index];
                  return Container(
                    width: 250,
                    margin: const EdgeInsets.only(right: 12),
                    child: Card(
                      color: Colors.orange[100],
                      elevation: 3,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notice['title']!,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              notice['summary']!,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // Latest Newsletters
            const Text(
              "Latest Newsletters",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: newsletters.length,
                itemBuilder: (context, index) {
                  final newsletter = newsletters[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      title: Text(newsletter['title']!),
                      subtitle: Text(newsletter['summary']!),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                      onTap: () {
                        // TODO: Navigate to newsletter detail page
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // Floating button for diary entry
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Navigate to create diary entry page
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.note_add, size: 28),
        tooltip: "Create Diary Entry",
      ),
    );
  }
}
