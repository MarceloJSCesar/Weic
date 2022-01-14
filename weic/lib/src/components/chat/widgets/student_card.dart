import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:weic/src/components/chat/widgets/mensages_screen.dart';
import 'package:weic/src/components/chat/widgets/profile_viewer.dart';
import 'package:weic/src/config/app_textstyles.dart';
import 'package:weic/src/models/mensage.dart';
import 'package:weic/src/models/student.dart';

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
        ? Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage:
                    NetworkImage(anotherStudent.profilePhoto as String),
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
                                  mensage: Mensage(
                                    timestamp: Timestamp.now(),
                                    mensage: '',
                                    senderId: myId,
                                    receiverId: anotherStudent.id,
                                    receiverName: anotherStudent.name,
                                    receiverPhoto: anotherStudent.profilePhoto,
                                    receiverProfileVerified:
                                        anotherStudent.isProfileVerified,
                                  ),
                                ),
                              ),
                            ),
                            child: FittedBox(
                              child: Text(
                                'Enviar Mensagem',
                                style: AppTextStyles.studentCardButtonTextStyle,
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
                                    studentID: anotherStudent.id as String,
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              'Ver Perfil',
                              style: AppTextStyles.studentCardButtonTextStyle,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        : Container();
  }
}
