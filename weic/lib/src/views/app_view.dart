import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../models/student.dart';
import '../views/chat/chat_view.dart';
import '../views/home/home_view.dart';
import '../views/profile/profile_view.dart';

class AppView extends StatefulWidget {
  final Student student;
  const AppView({
    Key? key,
    required this.student,
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
      HomeView(student: widget.student),
      ChatView(),
      ProfileView(),
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
              CupertinoIcons.person,
              size: 25,
            ),
          ),
        ],
        border: Border(
          top: BorderSide(color: Colors.transparent, width: 0.0),
        ),
        backgroundColor: Colors.transparent,
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
