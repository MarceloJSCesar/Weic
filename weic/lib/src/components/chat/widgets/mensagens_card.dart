import 'package:flutter/material.dart';
import 'package:weic/src/models/latestMensage.dart';

class MensagesCard extends StatelessWidget {
  final String myId;
  final LatestMensage latestMensage;
  const MensagesCard({
    Key? key,
    required this.myId,
    required this.latestMensage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('latestMensage from mensages card:' + latestMensage.toString());
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(
            latestMensage.receiverId == myId
                ? latestMensage.senderProfilePhoto as String
                : latestMensage.receiverProfilePhoto as String,
          ),
        ),
        title: Text(
          latestMensage.receiverId == myId
              ? latestMensage.senderName as String
              : latestMensage.receiverName as String,
        ),
        subtitle: Text(
          latestMensage.mensage as String,
        ),
      ),
    );
  }
}
