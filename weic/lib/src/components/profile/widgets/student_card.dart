import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../models/student.dart';
import '../../../models/latestMensage.dart';
import '../../../config/app_textstyles.dart';
import '../../../components/chat/widgets/mensages_screen.dart';
import '../../../components/profile/widgets/profile_viewer.dart';

class StudentCard extends StatelessWidget {
  final String myId;
  final Student student;
  const StudentCard({
    Key? key,
    required this.myId,
    required this.student,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(student.profilePhoto as String),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(student.name as String),
            ),
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
                              timestamp: Timestamp.fromMillisecondsSinceEpoch(
                                  DateTime.now().millisecondsSinceEpoch),
                              mensage: '',
                              senderId: myId,
                              senderName: student.name,
                              receiverId: student.id,
                              receiverName: student.name,
                              senderProfilePhoto: student.profilePhoto,
                              senderProfileVerified: student.isProfileVerified,
                              receiverProfilePhoto: student.profilePhoto,
                              receiverProfileVerified:
                                  student.isProfileVerified,
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
                              studentID: student.id as String,
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
    );
  }
}
