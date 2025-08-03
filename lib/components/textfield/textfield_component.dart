import 'package:admin_qurban_mart/constants.dart';
import 'package:flutter/material.dart';

class TextfieldComponent extends StatelessWidget {
  final String hintText;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final Color color;
  final TextInputType inputType;
  final String label;
  final bool enabled;
  final double? size;
  final int? maxLines;
  final TextAlignVertical? textAlignVertical;
  final Widget? prefixIcon;

  const TextfieldComponent(
      {super.key,
      this.hintText = "",
      this.onChanged,
      this.controller,
      this.color = Colors.white70,
      this.inputType = TextInputType.text,
      this.label = "",
      this.enabled = true,
      this.size,
      this.maxLines,
      this.textAlignVertical,
      this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return TextField(
        enabled: enabled,
        style: TextStyle(
            fontSize: size, color: inputTextColor, fontWeight: FontWeight.bold),
        textAlignVertical: textAlignVertical,
        keyboardType: inputType,
        controller: controller,
        onChanged: onChanged,
        cursorColor: inputBorderColor,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hintText,
          // label: Text(label),
          prefixIcon: prefixIcon,
          hintStyle: const TextStyle(
              color: inputHintColor, fontWeight: FontWeight.normal),
          filled: true,
          fillColor: inputFillColor,
          labelStyle: const TextStyle(fontSize: 12),
          contentPadding: const EdgeInsets.only(left: 30),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: inputBorderColor),
            borderRadius: BorderRadius.circular(15),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: disabledColor),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: inputBorderColor),
            borderRadius: BorderRadius.circular(15),
          ),
        ));
  }
}
