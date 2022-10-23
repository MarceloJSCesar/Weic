import 'dart:async';
import 'dart:io';

import 'package:crypton/crypton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_connection_checker/simple_connection_checker.dart';
import 'package:weic/src/views/login/login_view.dart';
import '../../../models/student.dart';
import '../../../views/app_view.dart';
import '../../../config/app_textstyles.dart';
import '../../../config/app_assetsnames.dart';
import '../../../services/home/home_services.dart';
import '../../../services/dados_essencial/dados_essencial_services.dart';

class InsertEssencialData extends StatefulWidget {
  final Student student;
  const InsertEssencialData({
    Key? key,
    required this.student,
  }) : super(key: key);

  @override
  _InsertEssencialDataState createState() => _InsertEssencialDataState();
}

class _InsertEssencialDataState extends State<InsertEssencialData>
    with DadosEssenciaisServices, AppTextStyles {
  Timer? _timer;
  bool? _canResendEmail;
  bool isLoading = false;
  bool? _isEmailVerified;
  File _imagePath = File('');
  bool? _isConnectedToInternet;
  final _homeServices = HomeServices();
  StreamSubscription? _streamSubscription;
  final _instance = FirebaseAuth.instance;
  final _user = FirebaseAuth.instance.currentUser;
  final _nameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _schoolYearTextController = TextEditingController();
  final _dadosEssenciasServices = DadosEssenciaisServices();

  @override
  void initState() {
    super.initState();
    SimpleConnectionChecker _simpleConnectionChecker = SimpleConnectionChecker()
      ..setLookUpAddress('pub.dev');
    _streamSubscription =
        _simpleConnectionChecker.onConnectionChange.listen((connection) {
      setState(() {
        _isConnectedToInternet = connection;
      });
    });
    if (_isConnectedToInternet == true) {
      _isEmailVerified = _instance.currentUser!.emailVerified;
      if (_isEmailVerified == false) {
        sendEmailVerification(user: _user as User);

        _timer = Timer.periodic(
          Duration(seconds: 3),
          (_) async {
            await _user!.reload();
            print('reloaded');
            setState(() {
              _isEmailVerified =
                  FirebaseAuth.instance.currentUser!.emailVerified;
            });
            if (_isEmailVerified == true) _timer!.cancel();
          },
        );
      }
      print('Email verificado: $_isEmailVerified');
    }
  }

  Future sendEmailVerification({required User user}) async {
    try {
      await user.sendEmailVerification();

      setState(() => _canResendEmail = false);
      Future.delayed(Duration(seconds: 10));
      setState(() => _canResendEmail = true);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 4),
          content: Text(error.toString()),
        ),
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isConnectedToInternet == false
        ? Center(
            child: Container(
              width: 150,
              height: 150,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Sem conexão com a internet',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 20,
                ),
              ),
            ),
          )
        : _isEmailVerified == false
            ? Container(
                color: Colors.black,
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Por favor, verifique seu email para continuar',
                    ),
                    Divider(),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                      ),
                      onPressed: _canResendEmail == false
                          ? null
                          : () async {
                              await sendEmailVerification(user: _user as User);
                              setState(() {});
                            },
                      child: Text(
                        'Reenviar email',
                        style: essentialDataResendEmailButtonTextStyle,
                      ),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                      ),
                      onPressed: _canResendEmail == false
                          ? null
                          : () {
                              _instance.signOut();
                              Navigator.pushReplacementNamed(
                                  context, LoginView.loginViewKey);
                            },
                      child: Text(
                        'Cancelar',
                        style: essentialDataCancelButtonTextStyle,
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Dados Essenciais',
                                style: AppTextStyles.titleBlackTextStyle,
                              ),
                            ),
                            SizedBox(height: 30),
                            _imagePath.path.length != 0
                                ? CircleAvatar(
                                    radius: 30,
                                    backgroundImage:
                                        FileImage(File(_imagePath.path)),
                                  )
                                : CircleAvatar(
                                    radius: 30,
                                    backgroundImage:
                                        AssetImage(AppAssetsNames.boyImageUrl),
                                  ),
                            Divider(),
                            Text('Carrega sua foto de:')
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          TextButton.icon(
                            onPressed: () async {
                              File? image = await _dadosEssenciasServices
                                  .takePhotoFromCamera();
                              if (image != null) {
                                setState(() {
                                  _imagePath = image;
                                });
                              }
                            },
                            icon: Text('Camera'),
                            label: Icon(Icons.camera),
                          ),
                          TextButton.icon(
                            onPressed: () async {
                              File? image = await _dadosEssenciasServices
                                  .pickPhotoFromGalery();
                              if (image != null) {
                                setState(() {
                                  _imagePath = image;
                                });
                              }
                            },
                            icon: Text('Galeria'),
                            label: Icon(Icons.photo_library),
                          ),
                        ],
                      ),
                      Divider(),
                      TextFormField(
                        controller: _nameTextController,
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.words,
                        onChanged: (val) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          labelText: 'Primeiro e Segundo nome',
                          hintText: 'ex: Marcelo Cesar',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 6),
                      TextFormField(
                        controller: _schoolYearTextController,
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.words,
                        onChanged: (val) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          labelText: 'Ano escolar',
                          hintText: 'ex: 10 ano',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 6),
                      TextFormField(
                        controller: _passwordTextController,
                        textInputAction: TextInputAction.done,
                        textCapitalization: TextCapitalization.words,
                        onChanged: (val) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          labelText: 'Criar nova password',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      isLoading == false
                          ? Container(
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: _imagePath.path.length > 0 &&
                                        _nameTextController.text.length > 0 &&
                                        _passwordTextController.text.length >=
                                            8 &&
                                        _schoolYearTextController.text.length >=
                                            3
                                    ? () async {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        await _dadosEssenciasServices
                                            .updatePassword(
                                                newPassword:
                                                    _passwordTextController
                                                        .text)
                                            .then((password) async {
                                          if ((password ?? '') == 'error') {
                                            setState(() {
                                              isLoading = false;
                                            });
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                duration: Duration(seconds: 3),
                                                content: Text(
                                                  'Palavra passe muito fraco, tente outra vez',
                                                ),
                                              ),
                                            );
                                          } else {
                                            RSAKeypair rsaKeypair =
                                                RSAKeypair.fromRandom();
                                            final encrypedPassword = rsaKeypair
                                                .publicKey
                                                .encrypt(_passwordTextController
                                                    .text);
                                            final _prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            final studentID =
                                                _prefs.getString('STUDENT_ID');
                                            final String _studentProfileImgUrl =
                                                await _dadosEssenciasServices
                                                    .uploadPhoto(
                                              student: widget.student,
                                              file: _imagePath,
                                            );
                                            Student student = Student(
                                              id: widget.student.id,
                                              email: widget.student.email,
                                              name: _nameTextController.text,
                                              followers:
                                                  widget.student.followers,
                                              following:
                                                  widget.student.following,
                                              profilePhoto:
                                                  _studentProfileImgUrl,
                                              schoolName:
                                                  widget.student.schoolName,
                                              isMemberOfCFESAD: widget
                                                  .student.isMemberOfCFESAD,
                                              password: encrypedPassword,
                                              isProfileVerified: widget
                                                  .student.isProfileVerified,
                                              posts: widget.student.posts,
                                              guests: widget.student.guests,
                                              chatRoomIds:
                                                  widget.student.chatRoomIds,
                                              schoolYear:
                                                  _schoolYearTextController
                                                      .text,
                                            );
                                            await _homeServices
                                                .sendEssentialStudentDataToFirebase(
                                              student: student,
                                            );
                                            setState(() {
                                              isLoading = false;
                                            });
                                            Navigator.of(context)
                                                .pushReplacement(
                                              MaterialPageRoute(
                                                builder: (_) => AppView(
                                                  studentID:
                                                      studentID as String,
                                                ),
                                              ),
                                            );
                                          }
                                        });
                                      }
                                    : null,
                                child: Container(
                                  width: 120,
                                  height: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: _imagePath.path.length > 0 &&
                                            _nameTextController.text.length > 2
                                        ? Colors.blue
                                        : Colors.grey,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      bottomRight: Radius.circular(16),
                                    ),
                                  ),
                                  child: Text(
                                    'Guardar',
                                    textAlign: TextAlign.center,
                                    style: AppTextStyles
                                        .dadosEssenciaisButtonTextStyle,
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              alignment: Alignment.center,
                              child: CircularProgressIndicator(
                                strokeWidth: 3.0,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.blue),
                              ),
                            ),
                      SizedBox(height: 16)
                    ],
                  ),
                ),
              );
  }
}
