import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../models/news.dart';
import '../../config/app_textstyles.dart';
import '../../services/home/home_services.dart';
import '../../components/news/widgets/news_body.dart';

class NewsView extends StatelessWidget {
  const NewsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeServices = HomeServices();
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Text(
                  'Noticias',
                  style: AppTextStyles.homeNoticiasTitleTextStyle,
                ),
              ),
              Expanded(
                flex: 9,
                child: FutureBuilder(
                  future: homeServices.getSapoNews(),
                  builder: (context, AsyncSnapshot snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return Center(
                          child: Text('no internet'),
                        );
                      // added shimmer instead circularProgressIndicator okay ?
                      case ConnectionState.waiting:
                        return Shimmer.fromColors(
                          baseColor: Colors.transparent,
                          highlightColor: Colors.grey[400] as Color,
                          child: ListView.builder(
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 300,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                width: MediaQuery.of(context).size.width - 16,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.yellow[800] as Color,
                                ),
                              );
                            },
                          ),
                        );
                      default:
                        if (snapshot.hasData) {
                          return Container(
                            height: MediaQuery.of(context).size.height - 220,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              clipBehavior: Clip.antiAlias,
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                final data = snapshot.data;
                                final news = News(
                                  lead: data[index]['lead'],
                                  title: data[index]['title']['short'],
                                  imageUrl:
                                      data[index]['images']['square'] != null
                                          ? data[index]['images']['square']
                                              ['urlTemplate']
                                          : null,
                                  description: data[index]['body'],
                                  newsUrl: data[index]['links']['shortUrl'],
                                );
                                return NewsBody(news: news);
                              },
                            ),
                          );
                        } else {
                          return Center(
                            child: Text('no internet'),
                          );
                        }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
