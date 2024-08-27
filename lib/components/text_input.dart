import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInput extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final prefixIconType;
  bool isNumber;

  TextInput({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.prefixIconType,
    this.isNumber = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please fill this field';
        }
        return null;
      },
      inputFormatters: isNumber
          ? <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ]
          : null,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      obscureText: obscureText,
      controller: controller,
      textAlign: TextAlign.start,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 13,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).primaryColor,
        labelText: hintText,
        prefixIcon: prefixIconType == null
            ? null
            : Icon(
                prefixIconType,
                color: Colors.black,
                size: 20,
              ),
        labelStyle: TextStyle(
          color: Theme.of(context).highlightColor,
          fontSize: 15,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          borderSide: BorderSide(
            width: 1,
            color: Theme.of(context).highlightColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            width: 1,
            color: Theme.of(context).highlightColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          borderSide: BorderSide(
            width: 1,
            color: Theme.of(context).highlightColor,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            width: 1,
            color: Theme.of(context).highlightColor,
          ),
        ),
      ),
    );
  }
}
