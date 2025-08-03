import 'package:admin_qurban_mart/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class TextfieldPasswordComponent extends StatelessWidget {
  final String hintText;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final Color color;
  final TextInputType inputType;
  final String label;
  final bool enabled;
  final double? size;
  final TextAlignVertical? textAlignVertical;

  const TextfieldPasswordComponent(
      {this.hintText = "",
      this.onChanged,
      this.controller,
      this.color = Colors.white70,
      this.inputType = TextInputType.text,
      this.label = "",
      this.enabled = true,
      this.size,
      this.textAlignVertical});

  @override
  Widget build(BuildContext context) {
    return ObxValue<RxBool>(
        (visiblePassword) => TextField(
            obscureText: visiblePassword.value,
            enabled: enabled,
            style: TextStyle(
                fontSize: size,
                color: inputTextColor,
                fontWeight: FontWeight.bold),
            textAlignVertical: textAlignVertical,
            keyboardType: inputType,
            controller: controller,
            onChanged: onChanged,
            cursorColor: inputBorderColor,
            decoration: InputDecoration(
              hintText: hintText,
              // label: Text(label),
              suffixIcon: IconButton(
                  onPressed: () {
                    visiblePassword.value = !visiblePassword.value;
                  },
                  icon: Icon(
                    visiblePassword.value
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: iconColor,
                  )),
              hintStyle: const TextStyle(
                  color: inputHintColor, fontWeight: FontWeight.normal),
              filled: true,
              fillColor: inputFillColor,
              labelStyle: TextStyle(fontSize: 12),
              contentPadding: EdgeInsets.only(left: 30),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: inputBorderColor),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: inputBorderColor),
                borderRadius: BorderRadius.circular(15),
              ),
            )),
        false.obs);
  }
}
