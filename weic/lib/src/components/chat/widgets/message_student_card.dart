import 'package:flutter/material.dart';
import '../../../models/latestMensage.dart';
import '../../../config/app_textstyles.dart';
import '../../../components/profile/widgets/profile_viewer.dart';

class MessageStudentCard extends StatelessWidget {
  final String myId;
  final LatestMensage latestMensage;
  const MessageStudentCard({
    Key? key,
    required this.myId,
    required this.latestMensage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(latestMensage.senderId == myId
              ? latestMensage.receiverProfilePhoto as String
              : latestMensage.senderProfilePhoto as String),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(latestMensage.senderId == myId
                ? latestMensage.receiverName as String
                : latestMensage.senderName as String),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ProfileViewer(
                            myID: myId,
                            studentID: latestMensage.senderId == myId
                                ? latestMensage.receiverId as String
                                : latestMensage.senderId as String),
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
