import 'package:flutter/material.dart';
import 'package:weic/src/config/app_textstyles.dart';
import 'package:weic/src/models/mensage.dart';
import 'package:weic/src/models/student.dart';

class MensagesCard extends StatelessWidget {
  final String myId;
  final Mensage mensage;
  const MensagesCard({
    Key? key,
    required this.myId,
    required this.mensage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(mensage.receiverPhoto as String),
        ),
        title: Text(mensage.receiverName as String),
        subtitle: Text(mensage.mensage as String),
      ),
    );
  }
}
