import 'package:flutter/material.dart';
import 'package:weic/src/models/student.dart';
import '../../../config/app_textstyles.dart';
import '../../../config/app_assetsnames.dart';

class AppBarComponent extends PreferredSize {
  final Student student;
  final BuildContext? context;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  AppBarComponent({
    this.scaffoldKey,
    this.context,
    required this.student,
  }) : super(
          preferredSize: Size.fromHeight(200),
          child: Container(
            // decoration: AppDecorations.homeviewDecoration,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        /*
                        GestureDetector(
                          child: Icon(
                            Icons.menu,
                            size: 25,
                            color: Colors.black,
                          ),
                          onTap: () => scaffoldKey!.currentState!.openDrawer(),
                        ),
                        */
                        student.profilePhoto == null
                            ? CircleAvatar(
                                radius: 20,
                                backgroundImage:
                                    AssetImage(AppAssetsNames.boyImageUrl),
                              )
                            : CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(
                                    student.profilePhoto as String),
                              )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: 'Bem Vindo, ',
                            style: AppTextStyles.title,
                            children: <TextSpan>[
                              TextSpan(
                                text: student.name ?? 'null',
                                style: AppTextStyles.titleBold,
                              ),
                            ],
                          ),
                        ),
                        Text(student.schoolName ?? 'null',
                            style: AppTextStyles.title),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
}
