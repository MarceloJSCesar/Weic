import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:weic/src/models/latestMensage.dart';
import 'package:weic/src/models/mensage.dart';
import 'package:weic/src/models/student.dart';

class ChatAllUsersService {
  final _instance = FirebaseFirestore.instance;
  final String userCollectionDocID = '-1-2-22-weic-MarceloCesar-';

  Future sendPrivateMessage({
    required String mensage,
    required String senderStudentId,
    required LatestMensage msg,
  }) async {}

  String createRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  Future<List<LatestMensage>>? getPrivateMessages(
      {required String myId}) async {
    List<LatestMensage> latestMensages = [];
    return latestMensages;
  }
}
