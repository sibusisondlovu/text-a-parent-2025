import 'package:flutter/material.dart';

import 'select_school_screen.dart';

class ChooseDistrictScreen extends StatelessWidget {
  static const String id = '/choose-district';

  final List<String> districts = ['Johannesburg', 'Cape Town', 'Durban', 'Pretoria'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select District')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: districts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(districts[index]),
            onTap: () {
              Navigator.pushNamed(
                context,
                SelectSchoolScreen.id,
                arguments: {'district': districts[index]},
              );
            },
          );
        },
      ),
    );
  }
}
