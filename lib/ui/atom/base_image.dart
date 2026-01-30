import 'package:flutter/material.dart';

class BaseImage extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final Widget? placeholder;
  final Widget? errorWidget;

  const BaseImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.placeholder,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      width: width,
      height: height,
      fit: BoxFit.contain,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return placeholder ?? SizedBox (
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
      },
      errorBuilder: (context, error, stackTrace) {
        return errorWidget ??
            const Icon(Icons.broken_image, color: Colors.grey);
      },
    );
  }
}
