import 'package:flutter/material.dart';

class TryAnimatedSlide extends StatefulWidget {
  const TryAnimatedSlide({super.key});

  @override
  State<TryAnimatedSlide> createState() => _TryAnimatedSlideState();
}

class _TryAnimatedSlideState extends State<TryAnimatedSlide> {
  double x = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Colors.red),
        AnimatedSlide(
          duration: Durations.medium4,
          offset: Offset(x, 0),
          child: Container(color: Colors.green),
        ),
        GestureDetector(
          onTap: () => setState(() => x = x == 0 ? -1 : 0),
        ),
      ],
    );
  }
}
