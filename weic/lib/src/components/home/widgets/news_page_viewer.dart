import 'package:flutter/material.dart';
import 'package:weic/src/config/app_textstyles.dart';
import 'package:weic/src/models/news.dart';

class NewsPageViewer extends StatelessWidget {
  final News news;
  const NewsPageViewer({
    Key? key,
    required this.news,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: false,
            floating: true,
            expandedHeight: 300,
            backgroundColor: Colors.transparent,
            flexibleSpace: Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              decoration: news.imageUrl != null
                  ? BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(news.imageUrl.toString()),
                      ),
                    )
                  : BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
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
          ),
        ],
      ),
    );
  }
}
