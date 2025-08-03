import 'package:admin_qurban_mart/components/text/text_component.dart';
import 'package:flutter/material.dart';

class ButtonComponent extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  final Function()? onPressed;
  final IconData? icon;

  const ButtonComponent(this.text,
      {Key? key,
      this.color = Colors.green,
      this.size = 12,
      required this.onPressed,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: color),
      onPressed: onPressed,
      child: Row(
        mainAxisSize:
            MainAxisSize.min, // Agar ukuran Row tidak mengambil seluruh lebar
        children: [
          TextComponent(
            text,
            color: Colors.white,
            size: size,
          ),
          if (icon != null) ...[
            const SizedBox(width: 8), // Jarak antara teks dan ikon
            Icon(
              icon,
              color: Colors.white,
              size: size + 4, // Menyesuaikan ukuran ikon
            ),
          ],
        ],
      ),
    );
  }
}
