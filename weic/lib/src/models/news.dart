class News {
  final String? title;
  final String? newsUrl;
  final String? imageUrl;
  final String? description;

  News({
    this.title,
    this.newsUrl,
    this.imageUrl,
    this.description,
  });

  News fromJson(Map<String, dynamic> json) {
    return News(
      description: json['body'],
      title: json['lead'],
      newsUrl: json['links/shortUrl'],
      imageUrl: json['images/square/urlTemplate'],
    );
  }
}
