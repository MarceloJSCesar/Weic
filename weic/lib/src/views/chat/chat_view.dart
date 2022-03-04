import 'package:flutter/material.dart';

import '../../config/app_textstyles.dart';

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
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Chat',
                style: AppTextStyles.homeNoticiasTitleTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
