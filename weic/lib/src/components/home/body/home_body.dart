import 'package:flutter/material.dart';
import 'package:weic/src/components/home/widgets/app_bar_component.dart';
import 'package:weic/src/config/app_textstyles.dart';
import 'package:weic/src/models/news.dart';
import 'package:weic/src/services/home/home_services.dart';
import '../../../config/app_decorations.dart';

class HomeBody extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const HomeBody({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeServices = HomeServices();
    return SafeArea(
      child: Container(
        decoration: AppDecorations.homeviewDecoration,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: AppBarComponent(
                context: context,
                scaffoldKey: scaffoldKey,
              ),
            ),
            Expanded(
              flex: 8,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
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
                              case ConnectionState.waiting:
                                return Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.black),
                                    strokeWidth: 3.0,
                                  ),
                                );
                              default:
                                if (snapshot.hasData) {
                                  return Container(
                                    height: MediaQuery.of(context).size.height -
                                        220,
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView.builder(
                                      clipBehavior: Clip.antiAlias,
                                      scrollDirection: Axis.vertical,
                                      itemCount: snapshot.data.length,
                                      itemBuilder: (context, index) {
                                        final data = snapshot.data;
                                        final news = News(
                                          title: data[index]['title']['short'],
                                          imageUrl: data[index]['images']
                                              ['square']['urlTemplate'],
                                          description: data[index]['body'],
                                          newsUrl: data[index]['links']
                                              ['shortUrl'],
                                        );
                                        return Column(
                                          children: [
                                            if (index <= 10)
                                              Text(
                                                news.title.toString(),
                                              ),
                                            if (index <= 10)
                                              Image(
                                                image: NetworkImage(
                                                  news.imageUrl.toString(),
                                                ),
                                              ),
                                            if (index >= 10)
                                              Text(
                                                news.title.toString(),
                                              ),
                                          ],
                                        );
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
            ),
          ],
        ),
      ),
    );
  }
}
