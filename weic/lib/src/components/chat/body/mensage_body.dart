import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:weic/src/components/chat/widgets/mensagens_card.dart';
import 'package:weic/src/components/chat/widgets/mensages_screen.dart';
import 'package:weic/src/models/mensage.dart';
import 'package:weic/src/models/student.dart';
import 'package:weic/src/services/chat/allUsers/chat_all_users_services.dart';

class MensageBody extends StatelessWidget {
  final String myId;
  const MensageBody({
    Key? key,
    required this.myId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _instance = FirebaseFirestore.instance;
    final _chatAllUsersServices = ChatAllUsersService();
    return FutureBuilder(
        future: _chatAllUsersServices.getAllStudents(),
        builder: (context, AsyncSnapshot studentSnapshots) {
          switch (studentSnapshots.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  strokeWidth: 3.0,
                ),
              );
            default:
              if (studentSnapshots.hasData) {
                List<Student> students = studentSnapshots.data;
                students
                    .remove(students.where((element) => element.id == myId));
                for (int i = 0; i < students.length; i++) {
                  return StreamBuilder(
                    stream: _instance
                        .collection('mensages')
                        .doc('MENSAGENS')
                        .collection('private')
                        .doc('PRIVATE')
                        .collection('private-mensagens')
                        .doc('PRIVATE-MENSAGENS')
                        .collection('message')
                        .orderBy('timestamp', descending: true)
                        .snapshots(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Center(
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.black),
                              strokeWidth: 3.0,
                            ),
                          );
                        default:
                          if (snapshot.hasData) {
                            var body = snapshot.data!.docs;
                            List<Mensage> allMensages = [];
                            Map<String, List<Mensage>> mensages = {};
                            body.forEach((mensage) {
                              allMensages
                                  .add(Mensage.fromDocument(mensage.data()));
                              mensages.addAll({
                                '${students[i].id}': allMensages
                                    .where((element) =>
                                        element.senderId == myId ||
                                        element.receiverId == myId)
                                    .toList(),
                              });
                            });
                            return ListView.builder(
                              itemCount: mensages.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => MensagesScreen(
                                        myId: myId,
                                        anotherStudent: students[i],
                                      ),
                                    ),
                                  ),
                                  child: mensages.values
                                          .toList()[index]
                                          .isNotEmpty
                                      ? MensagesCard(
                                          myId: myId,
                                          mensage: mensages[
                                              students[i].id as String]![index],
                                        )
                                      : Container(),
                                );
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
              } else {
                return Center(
                  child: Text('Nenhum estudante ainda'),
                );
              }
              return Center(
                child: Text('Nenhum estudante ainda'),
              );
          }
        });
  }
}
