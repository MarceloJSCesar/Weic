import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:weic/src/components/chat/widgets/mensagens_card.dart';
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
      future: _instance
          .collection('mensages')
          .doc('MENSAGENS')
          .collection('private')
          .doc('PRIVATE')
          .collection('private-mensagens')
          .doc('PRIVATE-MENSAGENS')
          .collection('message')
          .orderBy('timestamp', descending: true)
          .get(),
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
              var body = snapshot.data!.docs;
              List<Mensage> mensages = [];
              List<Mensage> senderMensages = [];
              List<Mensage> receiverMensages = [];
              body.forEach((mensage) {
                mensages.add(Mensage.fromDocument(mensage.data()));
              });
              return ListView.builder(
                itemCount: mensages.length,
                itemBuilder: (context, index) {
                  return MensagesCard(
                    myId: myId,
                    mensage: mensages[index],
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
}
