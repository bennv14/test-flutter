import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StarShape extends StatefulWidget {
  const StarShape({
    super.key,
    this.scale = 1,
    this.type = 'square',
  });

  final int scale;
  final String type;

  @override
  StarShapeState createState() => StarShapeState();
}

class StarShapeState extends State<StarShape> {
  late String stretchStarSvg;

  late String squareStarSvg;

  PictureInfo? pictureInfo;

  @override
  void initState() {
    stretchStarSvg =
        '''<svg xmlns="http://www.w3.org/2000/svg" width="24" height="41" viewBox="0 0 24 41" fill="none">
  <path fill-rule="evenodd" clip-rule="evenodd" d="M0.272918 17.8789C-0.0571831 17.9242 -0.0569455 18.5801 0.273949 18.614C6.29807 19.1937 11.1493 26.4405 11.7214 35.6538L11.9996 40.3339L12.2006 35.6286C12.5871 26.3895 17.2899 18.9577 23.296 18.0916C23.6263 18.0465 23.626 17.3902 23.295 17.3564C17.2708 16.7768 12.4356 9.52993 11.8635 0.316681C11.8375 -0.0993329 11.386 -0.0748821 11.3683 0.341881C10.9818 9.58098 6.279 16.9882 0.272918 17.8789Z" fill="#FCF7F0"/>
</svg>''';

    squareStarSvg =
        '''<svg xmlns="http://www.w3.org/2000/svg" width="45" height="45" viewBox="0 0 45 45" fill="none">
  <path fill-rule="evenodd" clip-rule="evenodd" d="M22.5 0C21.3776 3.60735 20.3172 6.72669 19.1024 9.40257C15.428 16.3639 9.85267 19.5015 0 22.5C12.7146 27.9655 18.1156 32.4888 22.5 45C26.8844 32.4888 32.2854 27.9655 45 22.5C35.1473 19.5015 29.572 16.3639 25.8976 9.40257C24.6828 6.72669 23.6224 3.60735 22.5 0Z" fill="white"/>
</svg>''';

    vg
        .loadPicture(
            SvgStringLoader(widget.type == 'square' ? squareStarSvg : stretchStarSvg),
            null)
        .then((value) {
      setState(() {
        pictureInfo = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        size: Size(widget.scale.toDouble() * 50, widget.scale.toDouble() * 50),
        painter: _StarShapePainter(pictureInfo, widget.scale.toDouble()));
  }
}

class _StarShapePainter extends CustomPainter {
  final PictureInfo? pictureInfo;
  final double scale;

  _StarShapePainter(this.pictureInfo, this.scale);

  @override
  void paint(Canvas canvas, Size size) {
    if (pictureInfo != null) {
      canvas.save();
      canvas.scale(scale, scale);
      canvas.drawPicture(pictureInfo!.picture);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
