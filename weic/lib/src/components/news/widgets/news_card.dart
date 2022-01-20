import 'package:flutter/material.dart';
import '../../../models/news.dart';
import '../../../config/app_textstyles.dart';

class NewsCard extends StatelessWidget {
  final News news;
  NewsCard({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 300,
        width: MediaQuery.of(context).size.width - 16,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(news.imageUrl.toString()),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(16),
          ),
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: const EdgeInsets.all(16),
            child: Text(
              '${news.title}',
              textAlign: TextAlign.start,
              style: AppTextStyles.homeNoticiasCardTitleTextStyle,
            ),
          ),
        ),
      ),
    );
  }
}
