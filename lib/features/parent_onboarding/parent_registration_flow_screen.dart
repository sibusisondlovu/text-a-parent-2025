import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_spinkit/flutter_spinkit.dart';


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
  String selectedSchool = '';
  String password = '';
  bool isLoading = false;
  List<dynamic> allSchools = [];
  List<dynamic> filteredSchools = [];
  TextEditingController searchController = TextEditingController();
  Map<String, dynamic>? selectedChild;
  Map<String, dynamic>? selectedSchoolDetails;
  bool isSchoolRegistered = false;
  bool checkedSchool = false;
  List<dynamic> matchedLearners = [];
  bool fetchedLearners = false;

  int _currentPage = 0;


  @override
  void initState() {
    super.initState();
    loadSchools();
  }

  void _nextPage() async {
    if (_currentPage == 0) {
      if (_formKey.currentState?.validate() != true) {
        return; // Don't proceed if form is invalid
      }
    }

    if (_currentPage == 1) {
      if (selectedSchoolDetails != null && selectedSchoolDetails!['emis'] != null) {
        setState(() => isLoading = true);
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SpinKitFadingCircle(color: Colors.blue, size: 50),
                SizedBox(height: 16),
                Text('Fetching learners...', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        );
        await fetchLearners(selectedSchoolDetails!['emis']);
        Navigator.of(context).pop();
        setState(() => isLoading = false);
      } else {
        _showError('Please select a valid school before continuing.');
      }
    } else {
      if (_currentPage < 3) {
        _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
        setState(() => _currentPage++);
      }
    }
  }


  void _goBack() {
    if (_currentPage > 0) {
      _controller.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      setState(() {
        _currentPage--;
      });
    }
  }

  Future<void> loadSchools() async {
    final String response = await rootBundle.loadString('lib/assets/data/schools.json');
    final data = jsonDecode(response) as List<dynamic>;

    setState(() {
      allSchools = data;
      filteredSchools = data;
    });
  }

  Future<void> sendUserToBackend({
    required String uid,
    required String fullNames,
    required String email,
  }) async {
    const url = 'http://192.168.8.25:3000/api/users/register';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'uid': uid,
          'full_names': fullNames,
          'email': email,
          'role': 'parent',
          'is_verified': false,
        }),
      );

      if (response.statusCode == 201) {
        debugPrint('User saved to MySQL successfully.');
      } else {
        final error = jsonDecode(response.body);
        debugPrint('Error from backend: ${error['message']}');
      }
    } catch (e) {
      debugPrint('HTTP error: $e');
    }
  }


  Future<void> fetchLearners(String emis) async {
    setState(() {
      fetchedLearners = false;
      matchedLearners = [];
    });

    final response = await http.post(
      Uri.parse('http://192.168.8.25:3000/api/learners'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'emis': emis, 'parent_id_number': '84121855'}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final learners = data['learners'];

      if (learners != null && learners.isNotEmpty) {
        setState(() {
          matchedLearners = learners;
          fetchedLearners = true;
          _currentPage++;
        });
        _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      } else {
        _showError('No learners found.');
      }
    } else {
      _showError('Error fetching learners.');
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
          _buildSchoolPage(theme),
          _buildLearnerPage(theme),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
            onPressed: _currentPage == 2 ? () async {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => const LoadingOverlay(message: 'Creating account...'),
              );

              try {
                final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email,
                  password: 'DefaultPassword123',
                );

                final user = userCredential.user;

                if (user != null) {

                  final uid = userCredential.user?.uid;
                   await sendUserToBackend(
                     uid: uid!,
                     fullNames: firstName,
                     email: email,
                   );

                  //   await user?.updateDisplayName('$firstName $lastName');
                  //   await user?.reload();
                  //   await userCredential.user?.sendEmailVerification();

                  final userDoc = FirebaseFirestore.instance.collection('users').doc(uid);

                  await userDoc.set({
                    'full_names': firstName,
                    'email': email,
                    'is_verified': false,
                    'created_at': FieldValue.serverTimestamp(),
                    'role': 'parent',
                  });

                  final learnersCollection = userDoc.collection('learners');

                  for (var learner in matchedLearners) {
                    await learnersCollection.doc(learner['admission_number']).set({
                      'learner_name': '${learner['full_names']} ${learner['surname']}',
                      'class': null, // default null or leave blank
                    });
                  }

                  await user.updateDisplayName(firstName);
                  await user.sendEmailVerification();

                  await user.reload(); // Optional: Ensure updates reflect immediately

                  // ✅ CLEAR all form data
                  setState(() {
                    firstName = '';
                    lastName = '';
                    email = '';
                    password = '';
                    selectedSchool = '';
                    selectedSchoolDetails = null;
                    matchedLearners = [];
                    fetchedLearners = false;
                    _currentPage = 0;
                    searchController.clear();
                  });

                  _controller.jumpToPage(0); // Reset page view
                }

                Navigator.of(context).pop(); // Close loading dialog

                Navigator.pushReplacementNamed(context, 'parentDashboard');
              } on FirebaseAuthException catch (e) {
                Navigator.of(context).pop();
                _showError(e.message ?? 'Firebase error occurred.');
                debugPrint('Firebase error: ${e.message}');
              } catch (e) {
                Navigator.of(context).pop();
                _showError('An error occurred. Please try again.');
                debugPrint('Unexpected error: $e');
              }
            } : _nextPage,
          child: Text(_currentPage == 2 ? 'Create Account' : 'Next'),
        ),
      ),
    );
  }

  Widget _buildNamePage(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('What is your name?', style: theme.textTheme.headlineSmall),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Full Name',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Full name is required';
                }
                return null;
              },
              onChanged: (value) => firstName = value.trim(),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email Address',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Email is required';
                }
                final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                if (!emailRegex.hasMatch(value)) {
                  return 'Enter a valid email address';
                }
                return null;
              },
              onChanged: (value) => email = value.trim(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLearnerPage(ThemeData theme) {
    if (!fetchedLearners || matchedLearners.isEmpty) {
      return const Center(child: Text('No learners found.'));
    }

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Your Learners', style: theme.textTheme.headlineSmall),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: matchedLearners.length,
              itemBuilder: (context, index) {
                final learner = matchedLearners[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text('${learner['full_names']} ${learner['surname']}'),
                    subtitle: Text(learner['admission_number']),

                  ),
                );
              },
            ),
          ),
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
          const SizedBox(height: 12),
          TextField(
            controller: searchController,
            decoration: const InputDecoration(
              labelText: 'Search for your school',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (query) {
              final suggestions = allSchools.where((school) {
                final name = school['school_name'].toString().toUpperCase();
                return name.contains(query.toUpperCase());
              }).toList();

              setState(() {
                filteredSchools = suggestions;
              });
            },
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: filteredSchools.length,
              itemBuilder: (context, index) {
                final school = filteredSchools[index];
                return ListTile(
                  title: Text(school['school_name']),
                  subtitle: Text('${school['emis']}'),
                  onTap: () async {
                    final emis = school['emis'];

                    setState(() {
                      selectedSchool = school['school_name'];
                      selectedSchoolDetails = school;
                      checkedSchool = true;
                    });

                  },
                  trailing: selectedSchool == school['school_name']
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : null,
                );
              },
            ),
          ),
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
