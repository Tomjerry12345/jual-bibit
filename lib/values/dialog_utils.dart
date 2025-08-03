import 'package:flutter/material.dart';

List<Widget> dialogShowAction(context, {Function()? onConfirm}) => [
      TextButton(
        child: const Text("Tidak"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      TextButton(
        child: const Text("Ya"),
        onPressed: onConfirm,
      ),
    ];

Future<void> dialogShow(context, {title, content, actions}) async {
  await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: content,
          actions: actions,
        );
      });
}

void dialogClose(context) {
  Navigator.of(context).pop();
}
