import 'package:flutter/material.dart';
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
                  backgroundColor: Colors.white,
                  automaticallyImplyLeading: false,
                  actions: <Widget>[
                    IconButton(
                        icon: Icon(
                          Icons.menu,
                          color: Colors.black,
                        ),
                        onPressed: () {}),
                  ],
                  flexibleSpace: Container(
                    height: 60,
                    alignment: Alignment.center,
                    clipBehavior: Clip.antiAlias,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            'https://esad.edu.cv/wp-content/uploads/elementor/thumbs/Logotipo-ESAD_logo-esad-web-osdj3woeu8t0tmfzj25flhbbx9igf1c197puqs7b7o.png'),
                      ),
                    ),
                  ),
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(120),
                    child: CircleAvatar(
                      backgroundImage:
                          NetworkImage(student.profilePhoto as String),
                    ),
                  ),
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
