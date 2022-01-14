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
                            List<String> msgIds = [];
                            List<Mensage> listMsg = [];
                            List<Mensage> allMensages = [];
                            List<Mensage> myMensages = [];
                            Map<String, Mensage> studentsMensages = {};
                            body.forEach((mensage) {
                              allMensages
                                  .add(Mensage.fromDocument(mensage.data()));
                            });
                            for (int index = 0;
                                index < students.length;
                                index++) {
                              for (int i = 0; i < allMensages.length; i++) {
                                if (allMensages[i].senderId == myId ||
                                    allMensages[i].receiverId == myId) {
                                  listMsg.add(allMensages[i]);
                                }
                              }
                              for (int i = 0; i < listMsg.length; i++) {
                                if (listMsg[i].senderId == myId) {
                                  studentsMensages.addAll(
                                      {'${listMsg[i].receiverId}': listMsg[i]});
                                } else {
                                  studentsMensages.addAll(
                                      {'${listMsg[i].senderId}': listMsg[i]});
                                }
                              }
                              for (int i = 0; i < listMsg.length; i++) {
                                print('msg: ' + studentsMensages.toString());
                                return ListView.builder(
                                    itemCount: studentsMensages.length,
                                    itemBuilder: (context, msgIndex) {
                                      listMsg.forEach((element) {});
                                      return GestureDetector(
                                        onTap: () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => MensagesScreen(
                                                myId: myId,
                                                mensage: studentsMensages
                                                        .containsKey(
                                                            listMsg[i].senderId)
                                                    ? studentsMensages[
                                                            listMsg[i].senderId
                                                                as String]
                                                        as Mensage
                                                    : studentsMensages[
                                                            listMsg[i]
                                                                    .receiverId
                                                                as String]
                                                        as Mensage),
                                          ),
                                        ),
                                        child: studentsMensages.length > 0
                                            ? MensagesCard(
                                                myId: myId,
                                                mensage: studentsMensages
                                                        .containsKey(
                                                            listMsg[i].senderId)
                                                    ? studentsMensages[
                                                            listMsg[i].senderId
                                                                as String]
                                                        as Mensage
                                                    : studentsMensages[
                                                            listMsg[i]
                                                                    .receiverId
                                                                as String]
                                                        as Mensage)
                                            : Container(),
                                      );
                                    });
                              }
                            }
                          } else {
                            return Center(
                              child: Text('Nenhum mensagem ainda'),
                            );
                          }
                      }

                      return Center(
                        child: Text('Nenhum estudante ainda'),
                      );
                    });
              }
          }
          return Center(
            child: Text('Nenhum estudante ainda'),
          );
        });
  }
}
