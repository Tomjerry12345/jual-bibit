import 'package:flutter/material.dart';

showConfirmDialog(
    {required BuildContext context,
    String title = "",
    String message = "",
    Function()? onConfirm}) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: const Text('Batal', style: TextStyle(color: Colors.green)),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = TextButton(
    child: Text(
      "Ya",
      style: TextStyle(color: Colors.red),
    ),
    onPressed: () {
      if (onConfirm != null) onConfirm();
      Navigator.of(context).pop();
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
