import 'package:flutter/material.dart';
import '../../../models/student.dart';
import '../../../config/app_decorations.dart';
import '../../../config/app_textstyles.dart';
import '../../../components/home/widgets/app_bar_component.dart';

class HomeBody extends StatelessWidget {
  final Student student;
  final GlobalKey<ScaffoldState> scaffoldKey;
  const HomeBody({
    Key? key,
    required this.student,
    required this.scaffoldKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                student: student,
              ),
            ),
            Expanded(
              flex: 8,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.black,
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
                      Expanded(flex: 9, child: Text(student.toString())),
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
