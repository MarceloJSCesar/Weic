import 'package:flutter/material.dart';
import 'package:weic/src/config/app_textstyles.dart';
import 'package:weic/src/models/news.dart';

class NewsCardOnlyTitle extends StatelessWidget {
  final News news;
  const NewsCardOnlyTitle({
    Key? key,
    required this.news,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 80,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        news.title.toString(),
        style: AppTextStyles.homeNoticiasCardTitleTextStyle,
      ),
    );
  }
}
