import 'package:flutter/material.dart';

class textfield extends StatelessWidget {
  textfield({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.labelText,
    required this.validator,
    required this.keyboardType,
    this.suffixIcon,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  String? labelText;
  String? Function(String?)? validator;
  TextInputType? keyboardType;
  Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.white70),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal),
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white70),
          borderRadius: BorderRadius.circular(15),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red.shade700),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: validator,
      onTapOutside: (event) {
        focusNode.unfocus();
      },
    );
  }
}
