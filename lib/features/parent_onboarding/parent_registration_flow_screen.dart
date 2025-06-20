import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../utils/loading_overlay.dart';

class ParentRegistrationFlowScreen extends StatefulWidget {
  static const String id = '/parentRegistration';

  const ParentRegistrationFlowScreen({super.key});

  @override
  State<ParentRegistrationFlowScreen> createState() => _ParentRegistrationFlowScreenState();
}

class _ParentRegistrationFlowScreenState extends State<ParentRegistrationFlowScreen> {
  final PageController _controller = PageController();

  final _formKey = GlobalKey<FormState>();

  String firstName = '';
  String lastName = '';
  String email = '';
  String password = '';
  bool isLoading = false;
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

  Future<void> _registerParent() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);
    _formKey.currentState!.save();

    try {
      // Firebase authentication
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final uid = userCredential.user?.uid;

      // Send email verification
      await userCredential.user?.sendEmailVerification();

      // Send user info to backend
      final response = await http.post(
        Uri.parse('https://yourdomain.com/api/users/register'),
        body: jsonEncode({
          'uid': uid,
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registered! Please verify your email.')),
        );

        // TODO: Navigate to next onboarding step (e.g., select district/school)
      } else {
        final error = jsonDecode(response.body)['message'];
        throw Exception(error);
      }
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
          _buildSchoolPage(theme),
          _buildChildSelectionPage(theme),
          _buildSummaryPage(theme),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: _currentPage == 5 ? () async {

            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const LoadingOverlay(message: 'Creating account...'),
            );

            try {
              // Register the user with Firebase
              final userCredential = await FirebaseAuth.instance
                  .createUserWithEmailAndPassword(email: email, password: 'DefaultPassword123');


              final user = userCredential.user;

              if (user != null) {
                await user.updateDisplayName('$firstName $lastName');
                await user.reload();
                await userCredential.user?.sendEmailVerification();
              }

              final uid = userCredential.user?.uid;

              // Send details to backend
              // final response = await http.post(
              //   Uri.parse('https://yourdomain.com/api/users/register'),
              //   headers: {'Content-Type': 'application/json'},
              //   body: jsonEncode({
              //     'uid': uid,
              //     'firstName': firstName,
              //     'lastName': lastName,
              //     'email': email,
              //     'school': selectedSchool,
              //   }),
              // );
              //
              // if (response.statusCode == 200) {
              //   // Navigate to dashboard or success screen
              //   Navigator.pushNamed(context, 'parentDashboard');
              // } else {
              //   _showError('Failed to register with backend.');
              // }
              Navigator.of(context).pop();
            } on FirebaseAuthException catch (e) {
              _showError(e.message ?? 'Firebase error occurred.');
            } catch (e) {
              _showError('An error occurred. Please try again.');
            }
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
          TextField(decoration: const InputDecoration(labelText: 'First Name'), onChanged: (v) => firstName = v),
          TextField(decoration: const InputDecoration(labelText: 'Surname'), onChanged: (v) => lastName = v),
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

  Widget _buildSchoolPage(ThemeData theme) {

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Select your school', style: theme.textTheme.headlineSmall),
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

          Text('Email: $email'),


        ],
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }
}
