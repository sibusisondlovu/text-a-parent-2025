
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:text_a_parent/screens/onboarding_screen.dart';

import 'utils/routes.dart';
import 'utils/theme.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // await dotenv.load();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp( const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text a Parent',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      onGenerateRoute: RouteGenerator.generateRoute,
      home: const OnboardingScreen(
        title: 'Welcome to Text-a-Parent',
        description: 'Let’s help you connect with school.',
        imageAsset: 'lib/assets/images/logo.jpeg',
      ),
    );
  }
}
