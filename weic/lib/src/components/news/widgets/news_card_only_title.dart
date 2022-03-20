import 'package:flutter/material.dart';
import '../../../models/news.dart';
import '../../../config/app_textstyles.dart';

class NewsCardOnlyTitle extends StatelessWidget {
  final News news;
  const NewsCardOnlyTitle({
    Key? key,
    required this.news,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
      ),
      child: FittedBox(
        child: Container(
          width: MediaQuery.of(context).size.width - 30,
          padding: const EdgeInsets.all(8.0),
          child: Text(
            news.title.toString(),
            maxLines: 3,
            style: AppTextStyles.homeNoticiasCardTitleTextStyle,
          ),
        ),
      ),
    );
  }
}
