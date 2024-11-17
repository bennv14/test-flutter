import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:test/extentions.dart';

class CalenderPainter extends CustomPainter {
  CalenderPainter({
    super.repaint,
    this.spaceRow = 6,
    this.spaceColumn = 8,
    this.normalDayColor = Colors.green,
    this.selectedDayColor = Colors.blue,
    this.saturdayColor = Colors.red,
    this.sundayColor = Colors.yellow,
    this.otherDayColor = Colors.grey,
    required this.selectedDate,
    required this.sleepForecastLevelPics,
  }) {
    _paintNormalDay = Paint()
      ..color = normalDayColor
      ..style = PaintingStyle.fill;

    _paintSelectedDay = Paint()
      ..color = selectedDayColor
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    _paintSaturday = Paint()
      ..color = saturdayColor
      ..style = PaintingStyle.fill;

    _paintSunday = Paint()
      ..color = sundayColor
      ..style = PaintingStyle.fill;

    _paintOtherDay = Paint()
      ..color = otherDayColor
      ..style = PaintingStyle.fill;

    _paintImage = Paint();
  }

  final double spaceRow;
  final double spaceColumn;
  final Color normalDayColor;
  final Color selectedDayColor;
  final Color saturdayColor;
  final Color sundayColor;
  final Color otherDayColor;
  final DateTime selectedDate;
  final List<ui.Image> sleepForecastLevelPics;

  late final Paint _paintNormalDay;
  late final Paint _paintSelectedDay;
  late final Paint _paintSaturday;
  late final Paint _paintSunday;
  late final Paint _paintOtherDay;
  late final Paint _paintImage;

  DateTime _computeStartDate() {
    final firstDateOfMonth = DateTime(selectedDate.year, selectedDate.month, 1);
    return DateTime(selectedDate.year, selectedDate.month, 1).subtract(
      Duration(days: firstDateOfMonth.weekday - 1),
    );
  }

  Paint _computeColorOfDate(DateTime date) {
    if (date.month != selectedDate.month || date.year != selectedDate.year) {
      return _paintOtherDay;
    }

    switch (date.weekday) {
      case DateTime.sunday:
        return _paintSunday;
      case DateTime.saturday:
        return _paintSaturday;
      default:
        return _paintNormalDay;
    }
  }

  void _drawImages({
    required Canvas canvas,
    required Size size,
    required ui.Image paintedImage,
    required Offset offset,
  }) {
    final ui.Rect rect = offset & size;
    final Size imageSize =
        Size(paintedImage.width.toDouble(), paintedImage.height.toDouble());

    FittedSizes sizes = applyBoxFit(BoxFit.contain, imageSize, size);

    final Rect inputSubRect = Alignment.center.inscribe(
      sizes.source,
      Offset.zero & imageSize,
    );

    final Rect outputSubRect = Alignment.center.inscribe(sizes.destination, rect);

    canvas.drawImageRect(paintedImage, inputSubRect, outputSubRect, _paintImage);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final widthOfDay = (width - spaceRow * 6) / 7;
    final height = size.height;
    final heightOfDay = (height - spaceColumn * 4) / 5;

    final startDate =
        selectedDate.getFirstDateOfCalendarMonth(startDayOfWeek: DateTime.tuesday);

    for (int i = 0; i < 5; i++) {
      for (int j = 0; j < 7; j++) {
        final datePaint = startDate.add(Duration(days: i * 7 + j));
        canvas.drawRect(
          Rect.fromLTWH(
            j * widthOfDay + j * spaceRow,
            i * heightOfDay + i * spaceColumn,
            widthOfDay,
            heightOfDay,
          ),
          _computeColorOfDate(datePaint),
        );
        TextPainter textPainter = TextPainter(
          text: TextSpan(text: datePaint.day.toString()),
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();

        textPainter.paint(
          canvas,
          Offset(
            j * widthOfDay + j * spaceRow + widthOfDay / 2 - textPainter.width / 2,
            i * heightOfDay + i * spaceColumn + 8,
          ),
        );
        _drawImages(
          canvas: canvas,
          size: Size(widthOfDay - 8, widthOfDay - 8),
          paintedImage: sleepForecastLevelPics[0],
          offset: Offset(
            j * widthOfDay + j * spaceRow + 4,
            i * heightOfDay + i * spaceColumn + 25,
          ),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
