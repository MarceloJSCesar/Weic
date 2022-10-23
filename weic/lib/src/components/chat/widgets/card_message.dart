import 'package:flutter/material.dart';

class CardMessage extends StatelessWidget {
  final bool isMe;
  final String mensage;
  const CardMessage({
    Key? key,
    required this.isMe,
    required this.mensage,
  }) : super(key: key);

  double get _maxWidth {
    final senderMensageLength = mensage.length;
    final receiverMensageLength = mensage.length;
    if (senderMensageLength >= 0 ||
        receiverMensageLength >= 0 && senderMensageLength <= 100 ||
        receiverMensageLength <= 100) {
      return 40;
    } else if (senderMensageLength >= 100 ||
        receiverMensageLength >= 100 && senderMensageLength <= 200 ||
        receiverMensageLength <= 200) {
      return 80;
    } else if (senderMensageLength >= 200 ||
        receiverMensageLength >= 200 && senderMensageLength <= 300 ||
        receiverMensageLength <= 300) {
      return 120;
    } else {
      return isMe ? mensage.length * 1.08 : mensage.length * 1.08;
    }
  }

  double get _maxHeight {
    final senderMensageLength = mensage.length;
    final receiverMensageLength = mensage.length;
    if (senderMensageLength >= 0 &&
        receiverMensageLength >= 0 &&
        senderMensageLength <= 20 &&
        receiverMensageLength <= 20) {
      return 100;
    } else {
      return isMe ? mensage.length * 8.0 : mensage.length * 8.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _maxHeight,
      height: _maxWidth,
      decoration: BoxDecoration(
        color: isMe ? Colors.grey.shade300 : Colors.blue,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(4),
      alignment: Alignment.center,
      child: isMe
          ? Text(
              mensage,
            )
          : Text(
              mensage,
            ),
    );
  }
}
