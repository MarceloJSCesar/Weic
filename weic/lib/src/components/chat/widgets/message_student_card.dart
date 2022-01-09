import 'package:flutter/material.dart';
import 'package:weic/src/components/chat/widgets/profile_viewer.dart';
import 'package:weic/src/config/app_textstyles.dart';
import 'package:weic/src/models/student.dart';

class MessageStudentCard extends StatelessWidget {
  final String myId;
  final Student anotherStudent;
  const MessageStudentCard({
    Key? key,
    required this.myId,
    required this.anotherStudent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(anotherStudent.profilePhoto as String),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(anotherStudent.name as String),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ProfileViewer(
                            myID: myId, studentID: anotherStudent.id as String),
                      ),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
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
