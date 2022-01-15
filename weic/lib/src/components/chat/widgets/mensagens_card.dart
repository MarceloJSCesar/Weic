import 'package:flutter/material.dart';
import 'package:weic/src/config/app_textstyles.dart';
import 'package:weic/src/models/latestMensage.dart';
import 'package:weic/src/models/mensage.dart';
import 'package:weic/src/models/student.dart';

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
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundImage:
              NetworkImage(latestMensage.receiverProfilePhoto as String),
        ),
        title: Text(latestMensage.receiverName as String),
        subtitle: Text(latestMensage.mensage as String),
      ),
    );
  }
}
