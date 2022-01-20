import 'package:flutter/material.dart';
import 'news_card.dart';
import 'news_card_only_title.dart';
import '../../../models/news.dart';
import '../view/news_page_viewer.dart';

class NewsBody extends StatelessWidget {
  final News? news;
  const NewsBody({
    Key? key,
    @required this.news,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (news!.imageUrl != null)
          GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => NewsPageViewer(
                  news: news as News,
                ),
              ),
            ),
            child: NewsCard(news: news as News),
          ),
        if (news!.imageUrl == null)
          GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => NewsPageViewer(
                  news: news as News,
                ),
              ),
            ),
            child: NewsCardOnlyTitle(
              news: news as News,
            ),
          ),
      ],
    );
  }
}
