class Newsletter {
  final int id;
  final String title;
  final String summary;
  final String fileLink;
  final String status;
  final DateTime date;

  Newsletter({
    required this.id,
    required this.title,
    required this.summary,
    required this.fileLink,
    required this.status,
    required this.date,
  });

  factory Newsletter.fromJson(Map<String, dynamic> json) {
    return Newsletter(
      id: json['id'],
      title: json['title'],
      summary: json['summary'],
      fileLink: json['file_link'],
      status: json['status'],
      date: DateTime.parse(json['date']),
    );
  }
}
