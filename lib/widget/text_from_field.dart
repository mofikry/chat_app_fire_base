import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomTextFromFiled extends StatelessWidget {
  CustomTextFromFiled(
      {super.key,
      required this.labelText,
      required this.hintText,
      this.onChange});
  final String labelText;
  final String hintText;
  Function(String)? onChange;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (data) {
        if (data!.isEmpty) {
          return "value is wrong";
        }
        return null;
      },
      onChanged: onChange,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
      ),
    );
  }
}
