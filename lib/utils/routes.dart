import 'package:flutter/material.dart';

import '../features/messaging/class_messages_screen.dart';
import '../features/messaging/diary_entry_screen.dart';
import '../features/parent_onboarding/parent_registration_flow_screen.dart';
import '../screens/onboarding_screen.dart';
import '../screens/parent_dashboard_screen.dart';
import '../screens/parent_onboarding_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments as dynamic;
    switch (settings.name) {
      case OnboardingScreen.id:
        return _route(
          OnboardingScreen(
            title: args['title'] ?? '',
            description: args['description'] ?? '',
            imageAsset: args['imageAsset'] ?? '',
          ),
        );
      case ParentOnboardingScreen.id:
        return _route(
          ParentOnboardingScreen(),
        );

      case ParentRegistrationFlowScreen.id:
        return _route(const ParentRegistrationFlowScreen());


      case ParentDashboardScreen.id:
        return _route(ParentDashboardScreen());

      case ClassMessagesScreen.id:
        return _route(const ClassMessagesScreen());

      case DiaryEntryScreen.id:
        return _route(const DiaryEntryScreen());

      default:
        return _errorRoute(settings.name);
    }
  }

  static MaterialPageRoute _route(Widget widget) =>
      MaterialPageRoute(builder: (context) => widget);

  static Route<dynamic> _errorRoute(String? name) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Route not found')),
        body: Center(
          child: Text(
            'ROUTE \n\n$name\n\nNOT FOUND',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
