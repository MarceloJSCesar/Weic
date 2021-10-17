import 'package:control_weic/src/components/login/login_field.dart';
import 'package:control_weic/src/components/login/logo_image.dart';
import 'package:control_weic/src/config/app_asset_name.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formkey = GlobalKey<FormState>();
  @override
  Scaffold build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(builder: (context, constraints) {
        bool isLandScapeMode = constraints.maxWidth > 610;
        return Container(
          alignment: Alignment.center,
          margin: isLandScapeMode
              ? const EdgeInsets.symmetric(vertical: 20)
              : const EdgeInsets.symmetric(vertical: 20),
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(child: Container()),
                LogoImage(isLandScapeMode: isLandScapeMode),
                SizedBox(height: 20),
                LoginField(formkey: _formkey, isEmailField: true),
                SizedBox(height: 20),
                LoginField(formkey: _formkey, isEmailField: false),
                Expanded(child: Container()),
                Text('Control.Weic'),
                Text('Desenvolvido pelo Marcelo Cesar'),
              ],
            ),
          ),
        );
      }),
    );
  }
}
