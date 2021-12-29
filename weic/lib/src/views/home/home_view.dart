import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypton/crypton.dart';
import 'package:flutter/material.dart';
import 'package:weic/src/components/home/widgets/insert_essencial_data_view.dart';
import 'package:weic/src/config/app_assetsnames.dart';
import 'package:weic/src/services/home/home_services.dart';
import '../../models/student.dart';
import '../../components/home/body/home_body.dart';
import '../../components/home/drawer/drawer_body.dart';
import 'package:uuid/uuid.dart';

class HomeView extends StatefulWidget {
  final Student? student;
  const HomeView({
    Key? key,
    this.student,
  }) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _studentCollection = FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    super.initState();
    _studentCollection.doc(widget.student!.id).get().then(
      (value) {
        print('value data: ${value.data()}');
        if (value.data() == null) {
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text('Dados Essenciais'),
                content: InsertEssencialData(),
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(child: DrawerBody()),
      body: HomeBody(
        scaffoldKey: _scaffoldKey,
        student: widget.student,
      ),
    );
  }
}
