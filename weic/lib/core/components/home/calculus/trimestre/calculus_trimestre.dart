import 'package:flutter/material.dart';
import 'package:weic/core/components/home/calculus/trimestre/calculus_page.dart';
import 'package:weic/core/config/app_textstyles.dart';

class CalculusTrimestre extends StatefulWidget {
  const CalculusTrimestre({Key key}) : super(key: key);

  @override
  _CalculusTrimestreState createState() => _CalculusTrimestreState();
}

class _CalculusTrimestreState extends State<CalculusTrimestre> {
  String optionSelected;
  List<String> options = [
    '1, 2 e 3 trimestre',
    '1 e 2 trimestre',
    '1 e 3 trimestre',
    '2 e 3 trimestre'
  ];
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
        centerTitle: true,
        title: Text(
          'Calcular nota do trimestre',
          style: AppTextStyles.hintTextStyle,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            DropdownButton(
              hint: Text(
                'Seleciona como deseja calcular a nota',
                style: AppTextStyles.hintTextStyle,
              ),
              value: optionSelected,
              onChanged: (val) => setState(() {
                optionSelected = val;
              }),
              items: options
                  .map((value) => DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      ))
                  .toList(),
            ),
            SizedBox(height: 30),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue)),
                onPressed: optionSelected != null
                    ? () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) =>
                            CalculusPage(optionSelected: optionSelected)))
                    : null,
                child: Text('Continuar'))
          ],
        ),
      ),
    );
  }
}
