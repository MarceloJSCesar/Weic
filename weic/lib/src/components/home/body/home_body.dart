import 'package:flutter/material.dart';
import 'package:weic/src/components/home/widgets/app_bar_component.dart';
import 'package:weic/src/components/home/widgets/news_card.dart';
import 'package:weic/src/components/home/widgets/news_card_only_title.dart';
import 'package:weic/src/components/home/widgets/news_page_viewer.dart';
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
                          'Posts',
                          style: AppTextStyles.homeNoticiasTitleTextStyle,
                        ),
                      ),
                      Expanded(flex: 9, child: Text('posts')),
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
