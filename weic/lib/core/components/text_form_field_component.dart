// import 'package:flutter/material.dart';
// import 'package:weic/core/config/app_textstyles.dart';
// import 'package:weic/core/models/user.dart';
// import 'package:weic/core/storage/db_storage.dart';

// // ignore: must_be_immutable
// class TextFormFieldComponent extends StatefulWidget {
//   var value;
//   var isLoading;
//   final String hintText;
//   final bool isPassword;
//   final formkey;
//   TextFormFieldComponent({
//     Key key,
//     this.value,
//     this.hintText,
//     this.formkey,
//     this.isPassword,
//   }) : super(key: key);

//   @override
//   _TextFormFieldComponentState createState() => _TextFormFieldComponentState();
// }

// class _TextFormFieldComponentState extends State<TextFormFieldComponent> {
//   void _submit() async {
//     User user = User();
//     DbStorage db = DbStorage();
//     final _form = widget.formkey.currentState;

//     if (_form.validate()) {
//       setState(() {
//         _form.save();
//         widget.isLoading = true;
//         user.name = name;
//         user.school = school;
//         user.email = email;
//         user.password = password;
//         user.sexuality = sexuality;
//       });
//       print(user.toString());
//       await db.registerUser(user);
//       await _registerServices.saveCacheData(user.email, user.name);
//       setState(() {
//         _isLoading = false;
//       });
//       Navigator.of(context).pushReplacementNamed('/login');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: TextFormField(
//         onSaved: (val) {
//           value = val;
//           print(widget.value);
//         },
//         onChanged: (val) => value = val,
//         style: AppTextStyles.dropDownTextStyle,
//         textInputAction:
//             !widget.isPassword ? TextInputAction.next : TextInputAction.done,
//         decoration: InputDecoration(
//           hintText: widget.hintText,
//           hintStyle: AppTextStyles.hintTextStyle,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//         ),
//       ),
//     );
//   }
// }
