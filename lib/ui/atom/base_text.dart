import 'package:deck_share/utils/app_color.dart';
import 'package:flutter/material.dart';

class BaseText extends StatelessWidget {
  final String data;
  final double? fontSize;
  final Color? color;

  const BaseText({super.key, required this.data, this.fontSize, this.color});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text(
      data,
      style: TextStyle(
        fontSize: fontSize ?? 10,
        color: color ?? AppColors.textPrimary,
      ),
    );
  }
}
