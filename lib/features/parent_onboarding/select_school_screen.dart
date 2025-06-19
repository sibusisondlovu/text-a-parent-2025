import 'package:flutter/material.dart';

import 'identify_children_screen.dart';

class SelectSchoolScreen extends StatelessWidget {
  static const String id = '/select-school';

  final List<String> schools = ['Greenfield Primary', 'Hope Valley High', 'Riverbank Academy'];

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final district = args['district'];

    return Scaffold(
      appBar: AppBar(title: Text('Schools in $district')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: schools.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(schools[index]),
            onTap: () {
              Navigator.pushNamed(
                context,
                IdentifyChildScreen.id,
                arguments: {
                  'district': district,
                  'school': schools[index],
                },
              );
            },
          );
        },
      ),
    );
  }
}
