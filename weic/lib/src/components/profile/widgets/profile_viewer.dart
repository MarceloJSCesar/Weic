import 'package:flutter/material.dart';
import '../../../models/student.dart';
import '../../../config/app_textstyles.dart';
import '../../../config/app_assetsnames.dart';
import '../../../services/students/students_services.dart';
import '../../../views/login/login_view.dart';
import '../../../services/home/home_services.dart';

class ProfileViewer extends StatefulWidget {
  final String studentID;
  final String myID;
  const ProfileViewer({
    Key? key,
    required this.myID,
    required this.studentID,
  }) : super(key: key);

  @override
  State<ProfileViewer> createState() => _ProfileViewerState();
}

class _ProfileViewerState extends State<ProfileViewer> {
  final _homeServices = HomeServices();
  bool isYouFollowing = false;
  bool isProfileViewer = true;
  final _studentServices = StudentsServices();
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
              student.followers!.contains(widget.myID) == true
                  ? isYouFollowing = true
                  : isYouFollowing = false;
              return Scaffold(
                appBar: AppBar(
                  elevation: 0.0,
                  centerTitle: false,
                  backgroundColor: Colors.black,
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
                                border: Border.all(color: Colors.white),
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
                                color: Colors.transparent,
                                border: Border.all(color: Colors.white),
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
                            color: Colors.transparent,
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            student.schoolName as String,
                            style: AppTextStyles.esadTextStyle,
                          ),
                        ),
                  actions: <Widget>[
                    isProfileViewer == false
                        ? IconButton(
                            iconSize: 27,
                            color: Colors.white,
                            icon: Icon(Icons.menu),
                            onPressed: () {},
                          )
                        : Container(),
                  ],
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    color: Colors.white,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                backgroundColor: Colors.black,
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
                            elevation: 6,
                            color: Colors.white,
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
                                  student.id != widget.myID
                                      ? GestureDetector(
                                          onTap: () async {
                                            if (isYouFollowing == false) {
                                              await _studentServices
                                                  .followStudent(
                                                studentID: widget.studentID,
                                                myID: widget.myID,
                                              );
                                              setState(() {
                                                isYouFollowing = true;
                                              });
                                            } else {
                                              await _studentServices
                                                  .unfollowStudent(
                                                studentID: widget.studentID,
                                                myID: widget.myID,
                                              );
                                              setState(() {
                                                isYouFollowing = false;
                                              });
                                            }
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
                                              student.guests!.length.toString(),
                                              style: AppTextStyles
                                                  .cardNumFollowsTextStyle,
                                            ),
                                          ],
                                        ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 22),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Posts',
                              style: AppTextStyles.profileTitleTextStyle,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            alignment: Alignment.centerLeft,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: student.posts != null &&
                                        student.posts!.length > 0
                                    ? MainAxisAlignment.start
                                    : MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(height: 16),
                                  student.posts != null &&
                                          student.posts!.length > 0
                                      ? Container(
                                          height: 100,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: student.posts!.length,
                                            itemBuilder: (context, index) {
                                              return Text(
                                                '${student.posts![index]}',
                                              );
                                            },
                                          ),
                                        )
                                      : Container(
                                          alignment: Alignment.center,
                                          child: Image(
                                            height: 200,
                                            fit: BoxFit.fill,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            image: AssetImage(AppAssetsNames
                                                .noPostYetImageUrl),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          )
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
