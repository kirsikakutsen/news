class NewsResponse {
  String? title;
  String? articleId;
  String? description;
  String? publishDate;
  String? publishDateTz;
  String? image;
  String? link;

  NewsResponse({
    this.title,
    this.articleId,
    this.description,
    this.publishDate,
    this.publishDateTz,
    this.image,
    this.link,
  });

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
      return NewsResponse(
        articleId: json['article_id'],
        title: json['title'],
        description: json['description'],
        publishDate: json['pubDate'],
        publishDateTz: json['pubDateTZ'],
        image: json['image_url'],
        link: json['link'],
      );
  }
  
}