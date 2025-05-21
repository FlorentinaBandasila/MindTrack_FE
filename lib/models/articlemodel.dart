class ArticleModel {
  final String title;
  final String link;
  final DateTime? createdDate;
  final String photo;

  ArticleModel(
      {required this.title,
      required this.link,
      required this.createdDate,
      required this.photo});
  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      title: json['title'],
      link: json['link'],
      createdDate: json['created_date'] != null
          ? DateTime.tryParse(json['created_date'])
          : null,
      photo: json['photo'],
    );
  }
}
