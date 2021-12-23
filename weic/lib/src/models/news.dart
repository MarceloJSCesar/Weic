class News {
  final String? lead;
  final String? title;
  final String? newsUrl;
  final String? imageUrl;
  final String? description;

  News({
    this.lead,
    this.title,
    this.newsUrl,
    this.imageUrl,
    this.description,
  });

  News fromJson(Map<String, dynamic> json) {
    return News(
      lead: json['lead'],
      title: json['title/short'],
      description: json['body'],
      newsUrl: json['links/shortUrl'],
      imageUrl: json['images/square/urlTemplate'],
    );
  }
}
