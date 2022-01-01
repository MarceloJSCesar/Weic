import 'package:flutter/material.dart';
import 'package:weic/src/models/student.dart';
import 'package:weic/src/services/home/home_services.dart';
import 'drawer_feautures.dart';
import '../../../config/app_textstyles.dart';
import '../../../config/app_assetsnames.dart';

class DrawerBody extends StatelessWidget {
  final String studentID;
  DrawerBody({
    Key? key,
    required this.studentID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: HomeServices().getStudentEssentialData(studentID: studentID),
      builder: (context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                strokeWidth: 3.0,
              ),
            );
          default:
            if (snapshot.hasData) {
              final student = Student.fromDocument(snapshot.data);
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(100),
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          student.profilePhoto == null
                              ? CircleAvatar(
                                  radius: 35,
                                  backgroundImage: AssetImage(
                                    AppAssetsNames.boyImageUrl,
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 35,
                                  backgroundImage: NetworkImage(
                                    student.profilePhoto as String,
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
                body: SafeArea(
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            student.profilePhoto == null
                                ? CircleAvatar(
                                    radius: 35,
                                    backgroundImage: AssetImage(
                                      AppAssetsNames.boyImageUrl,
                                    ),
                                  )
                                : CircleAvatar(
                                    radius: 35,
                                    backgroundImage: NetworkImage(
                                      student.profilePhoto as String,
                                    ),
                                  ),
                            SizedBox(height: 8),
                            Text(
                              student.name ?? 'sem nome',
                              style: AppTextStyles.hintTextStyle,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          DrawerFeatures(
                            title: 'Sobre o aplicativo',
                            onTap: () => Navigator.of(context).pushNamed(
                              '/home/drawer_about',
                            ),
                          ),
                          SizedBox(height: 8),
                          DrawerFeatures(
                            title: 'Sair',
                            onTap: () async {
                              //await LoginServices().logout();
                              //Navigator.of(context).pushReplacementNamed('/login');
                            },
                          ),
                        ],
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      ClipOval(
                        child: Image(
                          width: 100,
                          image: AssetImage(AppAssetsNames.logoImageUrl),
                        ),
                      ),
                      Text(
                        'Marcelo Cesar',
                        style: AppTextStyles.blackTextStyle,
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                child: Text(
                  'Erro ao carregar dados',
                  style: AppTextStyles.hintTextStyle,
                ),
              );
            }
        }
      },
    );
  }
}
