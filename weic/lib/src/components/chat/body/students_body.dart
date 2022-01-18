import 'package:flutter/material.dart';
import 'package:weic/src/components/chat/widgets/student_card.dart';
import 'package:weic/src/models/student.dart';
import 'package:weic/src/services/chat/allUsers/chat_all_users_services.dart';

class StudentsBody extends StatelessWidget {
  final String myId;
  const StudentsBody({
    Key? key,
    required this.myId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _chatAllUsersServices = ChatAllUsersService();
    return FutureBuilder(
      future: _chatAllUsersServices.getAllStudents(),
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
              students.removeWhere((student) => student.id == myId);
              return ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    return StudentCard(
                      student: students[index],
                      myId: myId,
                    );
                  });
            } else {
              return Center(
                child: Text('Nenhum estudante disponivel ainda'),
              );
            }
        }
      },
    );
  }
}
