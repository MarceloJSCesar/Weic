import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weic/src/config/app_textstyles.dart';
import 'package:weic/src/services/chat/allUsers/chat_all_users_services.dart';

class ChatView extends StatefulWidget {
  final String myId;
  const ChatView({
    Key? key,
    required this.myId,
  }) : super(key: key);

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Text(
            'Chat',
            style: AppTextStyles.homeNoticiasTitleTextStyle,
          ),
        ),
        backgroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      backgroundColor: Colors.white,
    );
  }
}
