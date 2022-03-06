import 'package:flutter/material.dart';
import '../../models/student.dart';
import '../../config/app_textstyles.dart';
import '../../config/app_assetsnames.dart';
import '../../views/login/login_view.dart';
import '../../views/splash/splash_view.dart';
import '../../services/home/home_services.dart';
import '../../services/login/login_services.dart';
import '../../components/profile/widgets/snackbar_text_button.dart';

class ProfileView extends StatefulWidget {
  final String studentID;
  const ProfileView({Key? key, required this.studentID}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool isYouFollowing = false;
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
                            color: Colors.black,
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            student.schoolName as String,
                            style: AppTextStyles.esadTextStyle,
                          ),
                        ),
                  actions: <Widget>[
                    student.id == widget.studentID
                        ? IconButton(
                            iconSize: 27,
                            color: Colors.white,
                            icon: Icon(Icons.menu),
                            onPressed: () => ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(
                              duration: Duration(seconds: 6),
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              behavior: SnackBarBehavior.floating,
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SnackbarTextButton(
                                    text: 'Ajuda',
                                    onPressed: () {},
                                  ),
                                  SnackbarTextButton(
                                    text: 'Melhorar o app',
                                    onPressed: () {},
                                  ),
                                  SnackbarTextButton(
                                    text: 'Definições',
                                    onPressed: () {
                                      print('tapped');
                                    },
                                  ),
                                  SnackbarTextButton(
                                    text: 'Sair',
                                    onPressed: () async {
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              LoginView.loginViewKey);
                                      setState(() {
                                        LoginServices().logoutUser();
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )),
                          )
                        : Container(),
                  ],
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
                                      height: 35,
                                      width: 35,
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
                                  student.id != widget.studentID
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
                            alignment: Alignment.center,
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
                                            fit: BoxFit.fill,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.20,
                                            image: AssetImage(
                                              AppAssetsNames.noPostYetImageUrl,
                                            ),
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
              return SplashView();
            }
        }
      },
    );
  }
}
