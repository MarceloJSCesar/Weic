import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weic/src/config/app_assetsnames.dart';
import 'package:weic/src/views/login/login_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation? _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController as AnimationController,
      curve: Curves.easeInToLinear,
    );
    _animationController?.forward();
    _animationController!.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(_animation!.value),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: Container()),
            Column(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  transitionOnUserGestures: true,
                  child: Image(
                    fit: BoxFit.fill,
                    height: _animation!.value * 350,
                    image: AssetImage(AppAssetsNames.logoImageUrl),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Seja Bem-Vindo !',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: _animation!.value * 22,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(top: 6.0),
                  child: Text(
                    'Um grande aplicativo que unem todos os estudantes da escola, oferecendo vários recursos, tudo em um só lugar.',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: _animation!.value * 19,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(child: Container()),
            GestureDetector(
              onTap: () => Navigator.of(context)
                  .pushReplacementNamed(LoginView.loginViewKey),
              child: Container(
                alignment: Alignment.center,
                child: Container(
                  height: 50,
                  width: 130,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0xFF03989e),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Prosseguir',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
