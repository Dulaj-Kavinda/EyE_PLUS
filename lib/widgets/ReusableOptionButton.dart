// ignore_for_file: file_names

import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReusableOptionButton extends StatelessWidget {
  const ReusableOptionButton(
      {required this.action_text,
      required this.icon,
      required this.onPressed,
      required this.button_color});

  final String action_text;
  final IconData icon;
  final void Function() onPressed;
  final Color button_color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 80,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          primary: button_color,
          //shape: const StadiumBorder(),
        ),
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: Colors.black54,
          size: 50.0,
        ),
        label: Text(
          action_text,
          style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w400
          ),
        ),
      ),
    );
  }
}
