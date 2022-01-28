import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weic/src/config/app_assetsnames.dart';

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
      curve: Curves.fastOutSlowIn,
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
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: Container()),
            Column(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Image(
                    fit: BoxFit.fill,
                    height: _animation!.value * 350,
                    image: AssetImage(AppAssetsNames.logoImageUrl),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Seja Bem-Vindo!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: _animation!.value * 22,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
