import 'package:flutter/material.dart';
import 'package:weic/src/components/chat/widgets/message_student_card.dart';
import 'package:weic/src/config/app_textstyles.dart';
import 'package:weic/src/models/student.dart';
import 'package:weic/src/services/chat/allUsers/chat_all_users_services.dart';

class MensagesScreen extends StatelessWidget {
  final String myId;
  final Student anotherStudent;
  const MensagesScreen({
    Key? key,
    required this.myId,
    required this.anotherStudent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _chatAllUsersServices = ChatAllUsersService();
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {},
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 16,
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Conversa com',
                  style: AppTextStyles.homeNoticiasTitleTextStyle,
                ),
              ),
              MessageStudentCard(
                myId: myId,
                anotherStudent: anotherStudent,
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Text('messages'),
          ),
          Container(
            height: 50,
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.photo_album),
                  color: Colors.black,
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.camera),
                  color: Colors.black,
                  onPressed: () {},
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Digite uma mensagem',
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  color: Colors.black,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
