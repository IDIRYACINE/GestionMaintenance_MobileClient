import 'package:flutter/material.dart';

class SettingTitle extends StatelessWidget {
  final String title;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;

  const SettingTitle(
      {super.key,
      required this.title,
      this.fontSize = 16,
      this.color = Colors.black,
      this.fontWeight = FontWeight.w500})
      ;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style:
          TextStyle(fontSize: fontSize, color: color, fontWeight: fontWeight),
    );
  }
}

class SettingsDescription extends StatelessWidget {
  final String description;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;

  const SettingsDescription(
      {super.key,
      required this.description,
      this.fontSize = 14,
      this.color = Colors.black,
      this.fontWeight = FontWeight.w400})
      ;

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style:
          TextStyle(fontSize: fontSize, color: color, fontWeight: fontWeight),
    );
  }
}
