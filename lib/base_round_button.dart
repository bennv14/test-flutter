import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BaseRoundButton extends StatelessWidget {
  const BaseRoundButton({
    super.key,
    this.isFullWidth = true,
    this.width,
    this.padding = const EdgeInsets.all(8),
    required this.child,
    this.backgroundColor = Colors.blue,
    this.borderColor,
  }) : assert(!(isFullWidth == true && width != null),
            'If isFullWidth is true, width must not be null.');

  final bool isFullWidth;
  final double? width;
  final EdgeInsetsGeometry padding;
  final Widget child;
  final Color backgroundColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isFullWidth ? double.infinity : width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: padding,
          side: borderColor != null ? BorderSide(color: borderColor!) : null,
        ),
        onPressed: () {
          SystemSound.play(SystemSoundType.click);
        },
        child: child,

      ),
    );
  }
}
