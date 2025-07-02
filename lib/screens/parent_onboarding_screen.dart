import 'package:flutter/material.dart';
import 'onboarding_page_content.dart';
import 'onboarding_screen.dart';

class ParentOnboardingScreen extends StatefulWidget {
  static const String id = '/parentOnboarding';

  const ParentOnboardingScreen({super.key});

  @override
  State<ParentOnboardingScreen> createState() => _ParentOnboardingScreenState();
}

class _ParentOnboardingScreenState extends State<ParentOnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> pages = [
    {
      'title': 'Stay Connected',
      'desc': 'Instantly receive updates from your child’s teacher, anytime, anywhere.',
      'img': 'lib/assets/images/1.jpeg',
    },
    {
      'title': 'Media Sharing',
      'desc': 'View classroom moments, shared videos, and learning photos.',
      'img': 'lib/assets/images/2.jpeg',
    },
    {
      'title': 'Message or Call Privately',
      'desc': 'Communicate securely with educators without exposing personal info.',
      'img': 'lib/assets/images/3.jpeg',
    },
    {
      'title': 'Join Class, Add Your Child',
      'desc': 'Start by adding your child and joining the right class.',
      'img': 'lib/assets/images/4.jpeg',
    },
  ];

  void _next() {
    if (_currentPage < pages.length - 1) {
      _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
    
      Navigator.pushNamed(context, '/parentRegistration');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _controller,
        itemCount: pages.length,
        onPageChanged: (index) => setState(() => _currentPage = index),
        itemBuilder: (_, index) {
          final page = pages[index];
          return OnboardingPageContent(
            title: page['title']!,
            description: page['desc']!,
            imageAsset: page['img']!,
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: _next,
          child: Text(_currentPage == pages.length - 1 ? 'Get Started' : 'Next'),
        ),
      ),
    );
  }
}
