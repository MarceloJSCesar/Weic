import 'package:flutter/material.dart';
import 'package:weic/src/components/insert_essential_data/widgets/student_card.dart';
import 'package:weic/src/config/app_assetsnames.dart';
import 'package:weic/src/models/student.dart';
import 'package:weic/src/services/students/students_services.dart';
import '/src/config/app_textstyles.dart';

class SearchStudentView extends StatefulWidget {
  final String studentID;
  const SearchStudentView({
    Key? key,
    required this.studentID,
  }) : super(key: key);

  @override
  State<SearchStudentView> createState() => _SearchStudentViewState();
}

class _SearchStudentViewState extends State<SearchStudentView> {
  final _studentServices = StudentsServices();
  TextEditingController? _studentSearchTextEditingController;

  @override
  void initState() {
    super.initState();
    _studentSearchTextEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 40,
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  controller: _studentSearchTextEditingController,
                  onSubmitted: (value) {
                    setState(() {
                      _studentSearchTextEditingController!.text = value;
                    });
                  },
                  style: AppTextStyles.searchStudentFieldTextStyle,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'exemplo: 10 ano',
                    prefix: Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () =>
                          _studentSearchTextEditingController!.text.length > 0
                              ? {
                                  _studentSearchTextEditingController!.clear(),
                                  setState(() {}),
                                }
                              : null,
                      icon: Icon(Icons.clear),
                    ),
                  ),
                ),
              ),
              Expanded(child: Container()),
              if (_studentSearchTextEditingController!.text.length > 3)
                Expanded(
                  child: FutureBuilder(
                    future: _studentServices.getUserBySchoolYear(
                      schoolYear: _studentSearchTextEditingController!.text,
                      myID: widget.studentID,
                    ),
                    builder: (context, AsyncSnapshot snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Center(
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.black),
                              strokeWidth: 3.0,
                            ),
                          );

                        default:
                          if (snapshot.hasData) {
                            List<Student> _students =
                                snapshot.data as List<Student>;

                            return ListView.builder(
                              itemCount: _students.length,
                              itemBuilder: (context, index) {
                                return StudentCard(
                                  myId: widget.studentID,
                                  student: _students[index],
                                );
                              },
                            );
                          } else {
                            print('no user');
                            return Center(
                              child: Text(
                                'Nenhum estudanto do ${_studentSearchTextEditingController!.text}',
                                style: AppTextStyles.titleBlackTextStyle,
                              ),
                            );
                          }
                      }
                    },
                  ),
                ),
              if (_studentSearchTextEditingController!.text.length <= 3)
                Container(
                  alignment: Alignment.center,
                  child: Image(
                    image: AssetImage(AppAssetsNames.searchStudentImageUrl),
                  ),
                ),
              Expanded(child: Container())
            ],
          ),
        ),
      ),
    );
  }
}
