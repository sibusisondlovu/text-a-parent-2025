import 'package:flutter/material.dart';

class ParentRegistrationFlowScreen extends StatefulWidget {
  static const String id = '/parentRegistration';

  const ParentRegistrationFlowScreen({super.key});

  @override
  State<ParentRegistrationFlowScreen> createState() => _ParentRegistrationFlowScreenState();
}

class _ParentRegistrationFlowScreenState extends State<ParentRegistrationFlowScreen> {
  final PageController _controller = PageController();

  // Collected form data
  String name = '';
  String surname = '';
  String email = '';
  String selectedDistrict = '';
  String selectedSchool = '';
  Map<String, dynamic>? selectedChild;

  int _currentPage = 0;

  final List<String> districts = ['Gauteng', 'Western Cape', 'KwaZulu-Natal'];
  final Map<String, List<String>> schoolsByDistrict = {
    'Gauteng': ['Sunrise High', 'Hope Primary'],
    'Western Cape': ['Ocean View School', 'Table Mountain Primary'],
    'KwaZulu-Natal': ['Durban Central', 'Umlazi Primary'],
  };

  final List<Map<String, dynamic>> mockChildren = [
    {'name': 'Emily Johnson', 'class': 'Grade 3', 'image': 'assets/images/child1.png'},
    {'name': 'Nathan Dube', 'class': 'Grade 1', 'image': 'assets/images/child2.png'},
  ];

  void _nextPage() {
    if (_currentPage < 5) {
      _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
    setState(() {
      _currentPage++;
    });
  }

  void _goBack() {
    if (_currentPage > 0) {
      _controller.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      setState(() {
        _currentPage--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Parent Registration'),
        leading: _currentPage > 0 ? IconButton(icon: const Icon(Icons.arrow_back), onPressed: _goBack) : null,
      ),
      body: PageView(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _buildNamePage(theme),
          _buildEmailPage(theme),
          _buildDistrictPage(theme),
          _buildSchoolPage(theme),
          _buildChildSelectionPage(theme),
          _buildSummaryPage(theme),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: _currentPage == 5 ? () {
            Navigator.pushNamed(context, 'parentDashboard');
            } : _nextPage,
          child: Text(_currentPage == 5 ? 'Finish' : 'Next'),
        ),
      ),
    );
  }

  Widget _buildNamePage(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Text('What is your name?', style: theme.textTheme.headlineSmall),
          TextField(decoration: const InputDecoration(labelText: 'First Name'), onChanged: (v) => name = v),
          TextField(decoration: const InputDecoration(labelText: 'Surname'), onChanged: (v) => surname = v),
        ],
      ),
    );
  }

  Widget _buildEmailPage(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Text('What is your email address?', style: theme.textTheme.headlineSmall),
          TextField(keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(labelText: 'Email'), onChanged: (v) => email = v),
        ],
      ),
    );
  }

  Widget _buildDistrictPage(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Select your district', style: theme.textTheme.headlineSmall),
          const SizedBox(height: 16),
          ...districts.map((district) => ListTile(
            title: Text(district),
            leading: Radio<String>(
              value: district,
              groupValue: selectedDistrict,
              onChanged: (v) => setState(() => selectedDistrict = v!),
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildSchoolPage(ThemeData theme) {
    final schools = schoolsByDistrict[selectedDistrict] ?? [];

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Select your school', style: theme.textTheme.headlineSmall),
          const SizedBox(height: 16),
          ...schools.map((school) => ListTile(
            title: Text(school),
            leading: Radio<String>(
              value: school,
              groupValue: selectedSchool,
              onChanged: (v) => setState(() => selectedSchool = v!),
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildChildSelectionPage(ThemeData theme) {
    return ListView(
      padding: const EdgeInsets.all(24.0),
      children: mockChildren.map((child) {
        return ListTile(
          leading: Image.asset(child['image'], width: 48),
          title: Text(child['name']),
          subtitle: Text(child['class']),
          trailing: ElevatedButton(
            onPressed: () => setState(() => selectedChild = child),
            child: const Text('Add'),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSummaryPage(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Summary', style: theme.textTheme.headlineMedium),
          const SizedBox(height: 16),
          Text('Name: $name $surname'),
          Text('Email: $email'),
          Text('District: $selectedDistrict'),
          Text('School: $selectedSchool'),
          if (selectedChild != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Child: ${selectedChild!['name']}'),
                Text('Class: ${selectedChild!['class']}'),
              ],
            ),
        ],
      ),
    );
  }
}
