import 'package:flutter/material.dart';
import '../../../models/news.dart';
import '../../../config/app_textstyles.dart';

class NewsPageViewer extends StatelessWidget {
  final News news;
  const NewsPageViewer({
    Key? key,
    required this.news,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: false,
            floating: true,
            expandedHeight: news.imageUrl != null ? 300 : 100,
            backgroundColor: Colors.transparent,
            flexibleSpace: SafeArea(
              child: Hero(
                tag: news.imageUrl != null ? news.imageUrl as String : '',
                child: Container(
                  height: news.imageUrl != null ? 300 : 100,
                  width: MediaQuery.of(context).size.width,
                  decoration: news.imageUrl != null
                      ? BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(news.imageUrl.toString()),
                          ),
                        )
                      : BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                          color: Colors.white.withOpacity(0.2),
                        ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
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
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
                margin: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${news.lead}',
                      style: AppTextStyles.homeViewerNoticiasTitleTextStyle,
                    ),
                    Divider(),
                    Text(
                      '${news.description}',
                      style: AppTextStyles.homeViewerNoticiasBodyTextStyle,
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
