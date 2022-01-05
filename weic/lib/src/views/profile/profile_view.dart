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
                      ? Container(
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
                            'CFESAD',
                            style: AppTextStyles.esadTextStyle,
                          ),
                        )
                      : Container(),
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
                          SizedBox(height: 8),
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
                          SizedBox(height: 8),
                          student.isProfileVerified == true
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(student.name as String),
                                    Image(
                                      height: 30,
                                      width: 30,
                                      image: AssetImage(
                                        AppAssetsNames.verifiedLogoImageUrl,
                                      ),
                                    ),
                                  ],
                                )
                              : Text(student.name as String),
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
