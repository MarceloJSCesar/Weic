import 'package:flutter/material.dart';
import 'package:weic/core/components/home/widgets/card_home_options.dart';
import 'package:weic/core/config/app_decorations.dart';
import 'package:weic/core/config/app_textstyles.dart';

class CardHome extends StatelessWidget {
  const CardHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: AppDecorations.drawerFeaturesDecoration,
      color: Colors.black,
      child: Container(
        height: 250,
        margin: const EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              CardHomeOptions(
                title: 'Calcular nota do trimestre',
                onTap: () {},
              ),
              SizedBox(
                width: 20,
              ),
              CardHomeOptions(
                title: 'Calcular nota do ciclo',
                onTap: () {},
              ),
              SizedBox(
                width: 20,
              ),
              CardHomeOptions(
                title: 'Calcular nota anual',
                onTap: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
