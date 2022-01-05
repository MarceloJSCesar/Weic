import 'package:flutter/material.dart';
import 'package:weic/src/config/app_assetsnames.dart';
import 'package:weic/src/config/app_textstyles.dart';
import 'package:weic/src/models/student.dart';
import 'package:weic/src/services/home/home_services.dart';
import 'package:weic/src/views/login/login_view.dart';

class ProfileView extends StatefulWidget {
  final String studentID;
  const ProfileView({Key? key, required this.studentID}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final _homeServices = HomeServices();
  bool isYouFollowing = false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          _homeServices.getStudentEssentialData(studentID: widget.studentID),
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
                  elevation: 0.0,
                  centerTitle: false,
                  backgroundColor: Colors.white,
                  title: student.isMemberOfCFESAD == true
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 27,
                              width: 70,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'CF${student.schoolName}',
                                style: AppTextStyles.esadTextStyle,
                              ),
                            ),
                            SizedBox(width: 6),
                            Container(
                              height: 27,
                              width: 50,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                student.schoolName as String,
                                style: AppTextStyles.esadTextStyle,
                              ),
                            ),
                          ],
                        )
                      : Container(
                          height: 27,
                          width: 50,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            student.schoolName as String,
                            style: AppTextStyles.esadTextStyle,
                          ),
                        ),
                  actions: <Widget>[
                    IconButton(
                      iconSize: 27,
                      color: Colors.black,
                      icon: Icon(Icons.menu),
                      onPressed: () {},
                    )
                  ],
                ),
                backgroundColor: Colors.white,
                body: CustomScrollView(
                  slivers: <Widget>[
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                            radius: 60,
                            backgroundImage:
                                NetworkImage(student.profilePhoto as String),
                          ),
                          SizedBox(height: 4),
                          student.isProfileVerified == true
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      student.name as String,
                                      style: AppTextStyles.studentNameTextStyle,
                                    ),
                                    Image(
                                      height: 30,
                                      width: 30,
                                      fit: BoxFit.fill,
                                      image: AssetImage(
                                        AppAssetsNames.verifiedLogoImageUrl,
                                      ),
                                    ),
                                  ],
                                )
                              : Text(
                                  student.name as String,
                                  style: AppTextStyles.studentNameTextStyle,
                                ),
                          SizedBox(height: 10),
                          Card(
                            elevation: 2,
                            color: Colors.black,
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        'Seguidores',
                                        style:
                                            AppTextStyles.cardFollowsTextStyle,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        student.followers!.length.toString(),
                                        style: AppTextStyles
                                            .cardNumFollowsTextStyle,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        'Seguindo',
                                        style:
                                            AppTextStyles.cardFollowsTextStyle,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        student.following!.length.toString(),
                                        style: AppTextStyles
                                            .cardNumFollowsTextStyle,
                                      ),
                                    ],
                                  ),
                                  student.id == widget.studentID
                                      ? GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isYouFollowing = !isYouFollowing;
                                            });
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 90,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: isYouFollowing == true
                                                  ? Colors.grey
                                                  : Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              isYouFollowing == true
                                                  ? 'Seguindo'
                                                  : 'Seguir',
                                              style: AppTextStyles
                                                  .cardFollowsTextStyle,
                                            ),
                                          ),
                                        )
                                      : Column(
                                          children: <Widget>[
                                            Text(
                                              'Visitantes',
                                              style: AppTextStyles
                                                  .cardFollowsTextStyle,
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              student.following!.length
                                                  .toString(),
                                              style: AppTextStyles
                                                  .cardNumFollowsTextStyle,
                                            ),
                                          ],
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return LoginView();
            }
        }
      },
    );
  }
}
