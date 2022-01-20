import 'package:flutter/material.dart';
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
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.black),
                            strokeWidth: 3.0,
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
