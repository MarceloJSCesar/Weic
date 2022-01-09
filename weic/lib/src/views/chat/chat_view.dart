import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weic/src/components/chat/body/mensage_body.dart';
import 'package:weic/src/components/chat/body/students_body.dart';
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

class _ChatViewState extends State<ChatView>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
          bottom: PreferredSize(
            preferredSize: Size.fromRadius(16),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(bottom: 10),
              child: TabBar(
                isScrollable: true,
                controller: _tabController,
                indicatorColor: Colors.black,
                automaticIndicatorColorAdjustment: true,
                tabs: <Widget>[
                  Tab(
                    icon: Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Mensagens',
                        textAlign: TextAlign.left,
                        style: AppTextStyles.chatTabTitleTextStyle,
                      ),
                    ),
                  ),
                  Tab(
                    icon: Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Estudantes',
                        style: AppTextStyles.chatTabTitleTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            MensageBody(senderID: widget.myId),
            StudentsBody(myId: widget.myId),
          ],
        ),
      ),
    );
  }
}
