import 'package:flutter/material.dart';
import 'package:weic/src/components/home/widgets/app_bar_component.dart';
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
              child: FutureBuilder(
                future: homeServices.getSapoNews(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height - 220,
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.all(16),
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                if (index <= 10)
                                  Text(
                                    snapshot.data[index]['title']['short']
                                        .toString(),
                                  ),
                                if (index <= 10)
                                  Image(
                                    image: NetworkImage(
                                      snapshot.data[index]['images']['square']
                                              ['urlTemplate']
                                          .toString(),
                                    ),
                                  ),
                                if (index >= 10)
                                  Text(snapshot.data[index]['title']['short']
                                      .toString()),
                              ],
                            );
                          },
                        ),
                      ),
                    );
                  } else {
                    return Center(
                      child: Text('No data ... ${snapshot.data}'),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
