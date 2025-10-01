import 'package:flutter/material.dart';
import '../models/newsletter_model.dart';
import '../services/api_service.dart';

class NewsletterProvider with ChangeNotifier {
  List<Newsletter> _newsletters = [];
  bool _loading = false;

  List<Newsletter> get newsletters => _newsletters;
  bool get loading => _loading;

  Future<void> loadNewsletters() async {
    _loading = true;
    notifyListeners();

    try {
      _newsletters = await ApiService.fetchNewsletters();
    } catch (e) {
      print('Error fetching newsletters: $e');
    }

    _loading = false;
    notifyListeners();
  }
}
