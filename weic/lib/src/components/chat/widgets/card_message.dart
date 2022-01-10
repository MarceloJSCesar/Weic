import 'package:flutter/material.dart';
import 'package:weic/src/models/mensage.dart';

class CardMessage extends StatelessWidget {
  final bool isMe;
  final String senderMensage;
  final String receiverMensage;
  const CardMessage({
    Key? key,
    required this.isMe,
    required this.senderMensage,
    required this.receiverMensage,
  }) : super(key: key);

  double get _maxWidth {
    final senderMensageLength = senderMensage.length;
    final receiverMensageLength = receiverMensage.length;
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
      return isMe ? senderMensage.length * 1.08 : receiverMensage.length * 1.08;
    }
  }

  double get _maxHeight {
    final senderMensageLength = senderMensage.length;
    final receiverMensageLength = receiverMensage.length;
    if (senderMensageLength >= 0 &&
        receiverMensageLength >= 0 &&
        senderMensageLength <= 20 &&
        receiverMensageLength <= 20) {
      return 100;
    } else {
      return isMe ? senderMensage.length * 8.0 : receiverMensage.length * 8.0;
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
              senderMensage,
            )
          : Text(
              receiverMensage.length <= 0 ? '' : receiverMensage,
            ),
    );
  }
}
