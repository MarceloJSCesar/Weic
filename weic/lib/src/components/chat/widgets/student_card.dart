import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:weic/src/components/chat/widgets/mensages_screen.dart';
import 'package:weic/src/components/chat/widgets/profile_viewer.dart';
import 'package:weic/src/config/app_textstyles.dart';
import 'package:weic/src/models/latestMensage.dart';
import 'package:weic/src/models/mensage.dart';
import 'package:weic/src/models/student.dart';
import 'package:weic/src/services/chat/allUsers/chat_all_users_services.dart';
import 'package:weic/src/services/home/home_services.dart';
import 'package:weic/src/views/login/login_view.dart';

class StudentCard extends StatelessWidget {
  final String myId;
  final Student anotherStudent;
  const StudentCard({
    Key? key,
    required this.myId,
    required this.anotherStudent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return anotherStudent.id != myId
        ? FutureBuilder(
            future: HomeServices().getStudentEssentialData(studentID: myId),
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
                    Student student = Student.fromDocument(snapshot.data);
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                              anotherStudent.profilePhoto as String),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(anotherStudent.name as String),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    height: 30,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: GestureDetector(
                                      onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => MensagesScreen(
                                            myId: myId,
                                            latestMensage: LatestMensage(
                                              chatRoomId: '',
                                              timestamp: Timestamp
                                                  .fromMillisecondsSinceEpoch(
                                                      DateTime.now()
                                                          .millisecondsSinceEpoch),
                                              mensage: '',
                                              senderId: myId,
                                              senderName: student.name,
                                              receiverId: anotherStudent.id,
                                              receiverName: anotherStudent.name,
                                              senderProfilePhoto:
                                                  student.profilePhoto,
                                              senderProfileVerified:
                                                  student.isProfileVerified,
                                              receiverProfilePhoto:
                                                  anotherStudent.profilePhoto,
                                              receiverProfileVerified:
                                                  anotherStudent
                                                      .isProfileVerified,
                                            ),
                                          ),
                                        ),
                                      ),
                                      child: FittedBox(
                                        child: Text(
                                          'Enviar Mensagem',
                                          style: AppTextStyles
                                              .studentCardButtonTextStyle,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 30,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(4),
                                    margin: const EdgeInsets.only(left: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => ProfileViewer(
                                              myID: myId,
                                              studentID:
                                                  anotherStudent.id as String,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'Ver Perfil',
                                        style: AppTextStyles
                                            .studentCardButtonTextStyle,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return LoginView();
                  }
              }
            })
        : Container();
  }
}
