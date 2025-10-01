import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/newsletter_model.dart';


class NewsletterCard extends StatelessWidget {
  final Newsletter newsletter;

  NewsletterCard(this.newsletter);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 6),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        title: Text(newsletter.title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text(newsletter.summary),
            SizedBox(height: 4),
            Text(DateFormat('yyyy-MM-dd – kk:mm').format(newsletter.date)),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.download),
          onPressed: () async {
            final url = newsletter.fileLink;
            //TODO
            // if (await canLaunch(url)) {
            //   await launch(url);
            // }
          },
        ),
      ),
    );
  }
}
