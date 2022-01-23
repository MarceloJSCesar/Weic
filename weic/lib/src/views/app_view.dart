import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../views/news/news_view.dart';
import '../views/home/home_view.dart';
import '../views/chat/chat_view.dart';
import '../views/profile/profile_view.dart';
import '../views/search_student/search_student_view.dart';

class AppView extends StatefulWidget {
  final String studentID;
  const AppView({
    Key? key,
    required this.studentID,
  }) : super(key: key);

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  List<Widget>? _pages;
  int? _selectPageIndex;
  PageController? _pageController;
  String defaultLocale = Platform.localeName;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomeView(studentID: widget.studentID),
      ChatView(myId: widget.studentID),
      NewsView(),
      SearchStudentView(studentID: widget.studentID),
      ProfileView(studentID: widget.studentID),
    ];
    _selectPageIndex = 0;
    _pageController = PageController(
      initialPage: _selectPageIndex!,
    );
    initializeDateFormatting(defaultLocale);
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        allowImplicitScrolling: true,
        clipBehavior: Clip.antiAlias,
        controller: _pageController,
        children: _pages!,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.home,
              size: 25,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.chat_bubble,
              size: 25,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.news,
              size: 25,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.search,
              size: 25,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.person,
              size: 25,
            ),
          ),
        ],
        border: Border(
          top: BorderSide(color: Colors.transparent, width: 0.0),
        ),
        backgroundColor: Colors.white,
        activeColor: Colors.lightBlue,
        inactiveColor: Colors.black,
        currentIndex: _selectPageIndex!,
        onTap: (selectedPageIndex) {
          setState(() {
            _selectPageIndex = selectedPageIndex;
            _pageController!.jumpToPage(selectedPageIndex);
          });
        },
      ),
    );
  }
}
