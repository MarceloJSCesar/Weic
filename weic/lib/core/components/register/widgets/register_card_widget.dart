import 'package:flutter/material.dart';
import 'package:weic/core/config/app_assets_names.dart';
import 'package:weic/core/config/app_textstyles.dart';

class RegisterBody extends StatefulWidget {
  @override
  _RegisterBodyState createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  String sexualitySelected;
  List<String> sexualities = ['Masculino', 'Femenino'];
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              ClipOval(
                child: Image(
                  width: 300,
                  image: AssetImage(AppAssetsNames.logoImageUrl),
                ),
              ),
              Card(
                elevation: 10.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.black,
                shadowColor: Colors.black,
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 30,
                  ),
                  child: Column(
                    children: <Widget>[
                      DropdownButton(
                        icon: Icon(Icons.arrow_drop_down),
                        dropdownColor: Colors.black,
                        value: sexualitySelected,
                        style: AppTextStyles.dropDownTextStyle,
                        onChanged: (value) {
                          setState(() {
                            sexualitySelected = value;
                            print(sexualitySelected);
                          });
                        },
                        hint: Text(
                          'Seleciona seu sexo',
                          style: AppTextStyles.dropDownTextStyle,
                        ),
                        items: sexualities.map((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Seu Nome',
                            hintStyle: AppTextStyles.hintTextStyle,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Nome Da Escola',
                            hintStyle: AppTextStyles.hintTextStyle,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.blue,
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          'Registrar',
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        child: Text(
                          'Ja tenho uma conta, Login',
                          style: AppTextStyles.hintTextStyle,
                        ),
                        onTap: () => Navigator.of(context)
                            .pushReplacementNamed('/login'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 345,
          left: MediaQuery.of(context).size.width / 2.3,
          child: CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(
              sexualitySelected == 'Masculino'
                  ? AppAssetsNames.boyImageUrl
                  : AppAssetsNames.womanImageUrl,
            ),
          ),
        ),
      ],
    );
  }
}
