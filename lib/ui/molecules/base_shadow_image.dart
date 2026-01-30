import 'package:deck_share/ui/atom/base_image.dart';
import 'package:flutter/material.dart';

class BaseShadowImage extends StatelessWidget {
  final BaseImage image;
  final Color? color;

  const BaseShadowImage({super.key, required this.image, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: image,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: color ?? Colors.amber, blurRadius: 5),
          BoxShadow(color: color ??Colors.amber, blurRadius: 10),
          BoxShadow(color: color ?? Colors.amber, blurRadius: 15),
        ],
      ),
    );
  }
}
