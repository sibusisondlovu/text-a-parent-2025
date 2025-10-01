import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/app_drawer.dart';
import '../components/newsletter_card.dart';
import '../providers/newsletter_provider.dart';


class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NewsletterProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Newsletters')),
      drawer: AppDrawer(),
      body: provider.loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        padding: EdgeInsets.all(8),
        itemCount: provider.newsletters.length,
        itemBuilder: (ctx, i) => NewsletterCard(provider.newsletters[i]),
      ),
    );
  }
}
