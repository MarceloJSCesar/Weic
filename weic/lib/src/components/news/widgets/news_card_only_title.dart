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
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
      ),
      child: FittedBox(
        child: Text(
          news.title.toString(),
          style: AppTextStyles.homeNoticiasCardTitleTextStyle,
        ),
      ),
    );
  }
}
