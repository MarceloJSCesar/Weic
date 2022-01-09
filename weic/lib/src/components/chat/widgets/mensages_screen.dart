import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:weic/src/components/chat/widgets/message_student_card.dart';
import 'package:weic/src/config/app_textstyles.dart';
import 'package:weic/src/models/mensage.dart';
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
    final _instance = FirebaseFirestore.instance;
    final _textController = TextEditingController();
    final _chatAllUsersServices = ChatAllUsersService();
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () => Navigator.of(context).pop(),
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
            child: StreamBuilder(
              stream: _instance
                  .collection('mensages')
                  .doc('MENSAGENS')
                  .collection('private')
                  .doc('PRIVATE')
                  .collection('private-mensagens')
                  .doc('PRIVATE-MENSAGENS')
                  .collection('message')
                  .orderBy('timestamp', descending: false)
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
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
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (listViewcontext, index) {
                          Map<String, dynamic> body =
                              snapshot.data!.docs[index].data();

                          return Text(
                            body['mensage'] as String,
                            style: AppTextStyles.blackTextStyle,
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: Text(
                          'Nenhuma mensagem ainda',
                          style: AppTextStyles.blackTextStyle,
                        ),
                      );
                    }
                }
              },
            ),
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
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: 'Digite uma mensagem',
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  color: Colors.black,
                  onPressed: () async =>
                      await _chatAllUsersServices.sendPrivateMessage(
                    mensage: _textController.text,
                    senderStudentId: myId,
                    receiverStudent: anotherStudent,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
