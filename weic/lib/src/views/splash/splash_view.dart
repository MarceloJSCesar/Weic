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
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween(begin: 0.0, end: 1.0)
        .animate(_animationController as AnimationController);
    _animation!.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(child: Container()),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image(
                  fit: BoxFit.fill,
                  height: _animation!.value * 140,
                  image: AssetImage(AppAssetsNames.logoImageUrl)),
              SizedBox(height: _animation!.value * 20),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Seja Bem-Vindo!',
                  style: TextStyle(
                    fontSize: _animation!.value * 22,
                  ),
                ),
              ),
            ],
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}
