import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/newsletter_provider.dart';
import 'screens/dashboard_screen.dart';
import 'services/notification_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService.init(); // Initialize OneSignal
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewsletterProvider()..loadNewsletters()),
      ],
      child: MaterialApp(
        title: 'Text-a-Parent',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: DashboardScreen(),
      ),
    );
  }
}
