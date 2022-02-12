import 'package:flutter/material.dart';

class TextFieldComponent extends StatelessWidget {
  final String label;
  const TextFieldComponent({
    Key? key,
    required this.label,
  }) : super(key: key);

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
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: label,
          prefix: const Padding(
            padding: const EdgeInsets.only(right: 8.0),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
