import 'package:justfood_multivendor/util/dimensions.dart';
import 'package:flutter/material.dart';

class IconWithTextRowWidget extends StatelessWidget {
  const IconWithTextRowWidget({
    super.key, required this.icon, required this.text, required this.style, this.color,
  });

  final IconData icon;
  final String text;
  final TextStyle style;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(icon, color: color ?? Theme.of(context).primaryColor, size: 20),
        const SizedBox(width: Dimensions.paddingSizeExtraSmall),
        Text(text, style: style),
      ],
    );
  }
}



class ImageWithTextRowWidget extends StatelessWidget {
  const ImageWithTextRowWidget({
    super.key, required this.widget, required this.text, required this.style, this.spacing = Dimensions.paddingSizeExtraSmall,
  });

  final Widget widget;
  final String text;
  final TextStyle style;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        widget, // The image or icon
        SizedBox(width: spacing), // Use the provided spacing
        Text(text, style: style),
      ],
    );
  }
}