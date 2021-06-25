import 'package:flutter/material.dart';
import 'package:weic/core/config/app_textstyles.dart';

class CalculusPage extends StatefulWidget {
  final String optionSelected;
  const CalculusPage({Key key, this.optionSelected}) : super(key: key);

  @override
  _CalculusPageState createState() => _CalculusPageState();
}

class _CalculusPageState extends State<CalculusPage> {
  final _nota1T = TextEditingController();
  final _nota2T = TextEditingController();
  final _nota3T = TextEditingController();
  final oea = TextEditingController();

  double _nota1;
  double _nota2;
  double _nota3;
  double _oea;

  double finalGrade;

  String option;

  @override
  void initState() {
    super.initState();
    setState(() {
      option = widget.optionSelected;
    });
    _nota1T.addListener(() {
      setState(() {
        _nota1 != null ? _nota1 = double.parse(_nota1T.text) : _nota1 = .0;
      });
    });
    _nota2T.addListener(() {
      setState(() {
        _nota2 != null ? _nota2 = double.parse(_nota2T.text) : _nota2 = .0;
      });
    });
    _nota3T.addListener(() {
      setState(() {
        _nota3 != null ? _nota3 = double.parse(_nota3T.text) : _nota3 = .0;
      });
    });
    oea.addListener(() {
      setState(() {
        _oea = double.parse(oea.text);
      });
    });
  }

  Widget get forms1 {
    if (option == '1, 2 e 3 trimestre' ||
        option == '1 e 2 trimestre' ||
        option == '1 e 3 trimestre') {
      return textField('Coloca nota do 1 trimestre', _nota1T);
    } else {
      return null;
    }
  }

  Widget get forms2 {
    if (option == '1, 2 e 3 trimestre' ||
        option == '1 e 2 trimestre' ||
        option == '2 e 3 trimestre') {
      Divider();
      return textField('Coloca nota do 2 trimestre', _nota2T);
    } else {
      return null;
    }
  }

  Widget get forms3 {
    if (option == '1, 2 e 3 trimestre' ||
        option == '1 e 3 trimestre' ||
        option == '2 e 3 trimestre') {
      Divider();
      return textField('Coloca nota do 3 trimestre', _nota3T);
    } else {
      return null;
    }
  }

  bool get validateButton {
    if (option == '1, 2 e 3 trimestre') {
      if (_nota1T.text.length > 1 &&
          _nota2T.text.length > 1 &&
          _nota3T.text.length > 1) {
        return true;
      } else {
        return false;
      }
    } else if (option == '1 e 2 trimestre') {
      if (_nota1T.text.length > 1 && _nota2T.text.length > 1) {
        return true;
      } else {
        return false;
      }
    } else if (option == '1 e 3 trimestre') {
      if (_nota1T.text.length > 1 && _nota3T.text.length > 1) {
        return true;
      } else {
        return false;
      }
    } else if (option == '2 e 3 trimestre') {
      if (_nota2T.text.length > 1 && _nota3T.text.length > 1) {
        return true;
      } else {
        return false;
      }
    } else {
      return null;
    }
  }

  double get calculateGrade {
    if (option == '1, 2 e 3 trimestre') {
      finalGrade = ((((_nota1 + _nota2 + _nota3) / 3) * .8) + (.2 * _oea));
      return finalGrade;
    } else if (option == '1 e 2 trimestre') {
      finalGrade = ((((_nota1 + _nota2) / 2) * .8) + (.2 * _oea));
      return finalGrade;
    } else if (option == '1 e 3 trimestre') {
      finalGrade = ((((_nota1 + _nota3) / 2) * .8) + (.2 * _oea));
      return finalGrade;
    } else if (option == '2 e 3 trimestre') {
      finalGrade = ((((_nota2 + _nota3) / 2) * .8) + (.2 * _oea));
      return finalGrade;
    } else {
      return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: .0,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Calcular nota do trimestre',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                SizedBox(
                  height: 40,
                ),
                forms1 == null ? Container() : forms1,
                Divider(),
                forms2 == null ? Container() : forms2,
                Divider(),
                forms3 == null ? Container() : forms3,
                Divider(),
                textField('Quanto tem na OEA ?', oea),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          validateButton == null || validateButton == false
                              ? Colors.grey
                              : Colors.blue)),
                  onPressed: validateButton == null || validateButton == false
                      ? null
                      : () {
                          calculateGrade;
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content:
                                      Text('Sua nota e de $finalGrade valores'),
                                );
                              });
                        },
                  child: Text('Calcular'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget textField(String hint, TextEditingController controller) {
  return TextField(
    controller: controller,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
      hintText: hint,
    ),
  );
}
