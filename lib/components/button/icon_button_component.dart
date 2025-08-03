import 'package:flutter/material.dart';

class IconButtonComponent extends StatelessWidget {
  final Color? color;
  final IconData icon;
  final Function()? onPressed;

  const IconButtonComponent(this.icon,
      {Key? key, this.color = Colors.green, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: color,
        ));
  }
}
