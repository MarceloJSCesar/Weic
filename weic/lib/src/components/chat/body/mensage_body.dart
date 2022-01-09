import 'package:flutter/material.dart';
import 'package:weic/src/models/student.dart';
import 'package:weic/src/services/chat/allUsers/chat_all_users_services.dart';

class MensageBody extends StatelessWidget {
  final String senderID;
  const MensageBody({
    Key? key,
    required this.senderID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _chatAllUsersServices = ChatAllUsersService();
    return FutureBuilder(
      future: _chatAllUsersServices.getPrivateMessages(senderID: senderID),
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
              final List<Student> students = snapshot.data;
              return ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  return Text('hi');
                },
              );
            } else {
              return Center(
                child: Text('Nenhum mensagem ainda'),
              );
            }
        }
      },
    );
  }
}
