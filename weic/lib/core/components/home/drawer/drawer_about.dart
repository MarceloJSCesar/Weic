import 'package:flutter/material.dart';
import 'package:weic/core/config/app_text.dart';
import '../../../config/app_textstyles.dart';
import '../../../config/app_decorations.dart';
import '../../../config/app_assets_names.dart';
import '../../../components/home/drawer/widgets/card_drawer_about.dart';

class DrawerAbout extends StatelessWidget {
  const DrawerAbout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: .0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            children: <Widget>[
              CardDrawerAbout(
                name: 'Marcelo Cesar \n Aluno da turma ES-3',
                imageUrl: AppAssetsNames.meImageUrl,
                description: 'Desenvolvedor desse Aplicativo',
              ),
              Divider(),
              CardDrawerAbout(
                name: 'Angelo Pinto',
                description: 'Diretor Da Turma: ES-3',
                imageUrl: AppAssetsNames.diretorImageUrl,
              ),
              Divider(),
              Card(
                elevation: 20.0,
                shape: AppDecorations.drawerFeaturesDecoration,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(
                        fit: BoxFit.cover,
                        height: 250,
                        image: AssetImage(AppAssetsNames.classmateImageUrl),
                      ),
                      Divider(),
                      Text(
                        'Minha Turma ES-3',
                        style: AppTextStyles.blackTextStyle,
                      ),
                      Text(
                        AppText.appInfText,
                        style: AppTextStyles.hintTextStyle,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
