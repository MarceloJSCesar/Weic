import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:weic/src/components/chat/widgets/mensagens_card.dart';
import 'package:weic/src/components/chat/widgets/mensages_screen.dart';
import 'package:weic/src/models/latestMensage.dart';
import 'package:weic/src/models/mensage.dart';
import 'package:weic/src/models/student.dart';
import 'package:weic/src/services/chat/allUsers/chat_all_users_services.dart';
import 'package:weic/src/views/login/login_view.dart';

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
    final String userCollectionDocID = '-1-2-22-weic-MarceloCesar-';
    return StreamBuilder(
        stream: _instance
            .collection('users')
            .doc(userCollectionDocID)
            .collection('students')
            .doc('student $myId')
            .snapshots(),
        builder: (context, AsyncSnapshot studentSnapshot) {
          switch (studentSnapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  strokeWidth: 3.0,
                ),
              );
            default:
              print('snapshot data: ${studentSnapshot.data}');
              if (studentSnapshot.hasData) {
                List<LatestMensage> latestMensages = [];
                List chatRoomIds = studentSnapshot.data!['chatRoomIds'];
                return ListView.builder(
                    itemCount: chatRoomIds.length,
                    itemBuilder: (context, chatRoomId) {
                      return StreamBuilder(
                        stream: _instance
                            .collection('chatRooms')
                            .doc(chatRoomIds[chatRoomId].toString())
                            .snapshots(),
                        builder: (context, AsyncSnapshot snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.black),
                                  strokeWidth: 3.0,
                                ),
                              );
                            default:
                              if (snapshot.hasData) {
                                latestMensages.add(
                                  LatestMensage.fromDocument(
                                    snapshot.data!['latestMensage'],
                                  ),
                                );
                                print(latestMensages.toString());
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  child: ListView.builder(
                                    itemCount: latestMensages.length,
                                    itemBuilder: (context, msgIndex) {
                                      return GestureDetector(
                                        onTap: () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => MensagesScreen(
                                              myId: myId,
                                              latestMensage:
                                                  latestMensages[msgIndex],
                                            ),
                                          ),
                                        ),
                                        child: latestMensages.length > 0
                                            ? MensagesCard(
                                                myId: myId,
                                                latestMensage:
                                                    latestMensages[msgIndex],
                                              )
                                            : Container(),
                                      );
                                    },
                                  ),
                                );
                              }
                              return Center(
                                child: Text('Nenhum mensagem ainda'),
                              );
                          }
                        },
                      );
                    });
              } else {
                return LoginView();
              }
          }
        });
  }
}
