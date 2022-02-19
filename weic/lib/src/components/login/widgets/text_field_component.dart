import 'package:flutter/material.dart';

class TextFieldComponent extends StatefulWidget {
  final String label;
  final bool isEmailField;
  final bool? isPasswordVisible;
  final viewPassword;
  final TextEditingController controller;
  const TextFieldComponent({
    Key? key,
    this.viewPassword,
    required this.label,
    this.isEmailField = true,
    required this.controller,
    this.isPasswordVisible,
  }) : super(key: key);

  @override
  State<TextFieldComponent> createState() => _TextFieldComponentState();
}

class _TextFieldComponentState extends State<TextFieldComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextField(
        controller: widget.controller,
        obscureText: widget.isEmailField
            ? false
            : widget.isPasswordVisible as bool
                ? false
                : true,
        textInputAction:
            widget.isEmailField ? TextInputAction.next : TextInputAction.done,
        keyboardType: widget.isEmailField
            ? TextInputType.emailAddress
            : TextInputType.visiblePassword,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
        onChanged: (e) {
          print(e);
        },
        decoration: InputDecoration(
          hintText: widget.label,
          border: InputBorder.none,
          prefix: const Padding(
            padding: const EdgeInsets.only(right: 8.0),
          ),
          suffixIcon: widget.isEmailField
              ? null
              : IconButton(
                  onPressed: widget.viewPassword,
                  icon: Icon(
                    widget.isPasswordVisible as bool
                        ? Icons.visibility_off
                        : Icons.visibility,
                    size: 18,
                  ),
                ),
        ),
      ),
    );
  }
}
