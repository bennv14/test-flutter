import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test/calender_painter.dart';
import 'dart:ui' as ui;

import 'package:test/extentions.dart';

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({
    super.key,
    this.spaceRow = 6,
    this.spaceColumn = 8,
    this.normalDayColor = Colors.green,
    this.selectedDayColor = Colors.blue,
    this.saturdayColor = Colors.red,
    this.sundayColor = Colors.yellow,
    this.otherDayColor = Colors.grey,
    required this.selectedDate,
  });

  final double spaceRow;
  final double spaceColumn;
  final Color normalDayColor;
  final Color selectedDayColor;
  final Color saturdayColor;
  final Color sundayColor;
  final Color otherDayColor;
  final DateTime selectedDate;

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  late final List<ui.Image> sleepForecastLevelPics;
  late final List<ui.Image> sleepLevelPics;

  @override
  void initState() {
    super.initState();

    sleepLevelPics = [];
    sleepForecastLevelPics = [];

    _getUiImage();
  }

  Future<void> _getUiImage() async {
    final pictureInfo =
        await vg.loadPicture(const SvgAssetLoader("assets/svg/sheep_1.svg"), null);
    sleepForecastLevelPics.add(await pictureInfoToUiImage(pictureInfo, 40, 40));
  }

  Future<ui.Image> pictureInfoToUiImage(
    PictureInfo pictureInfo,
    int targetWidth,
    int targetHeight,
  ) async {
    final ui.Picture picture = pictureInfo.picture;
    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final ui.Canvas canvas = Canvas(
      recorder,
      Rect.fromPoints(
        Offset.zero,
        Offset(targetWidth.toDouble(), targetHeight.toDouble()),
      ),
    );

    canvas.scale(
      targetWidth / pictureInfo.size.width,
      targetHeight / pictureInfo.size.height,
    );

    canvas.drawPicture(picture);
    return await recorder.endRecording().toImage(targetWidth, targetHeight);
  }

  DateTime _getDateOnTap(TapDownDetails details, BuildContext context) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset localPosition = details.localPosition;
    final double width = renderBox.size.width;
    final double height = renderBox.size.height;

    final double widthOfDay = (width - widget.spaceRow * 6) / 7;
    final double heightOfDay = (height - widget.spaceColumn * 4) / 5;

    final int x = (localPosition.dx / (widthOfDay + widget.spaceRow)).floor();
    final int y = (localPosition.dy / (heightOfDay + widget.spaceColumn)).floor();
    return widget.selectedDate
        .getFirstDateOfCalendarMonth()
        .add(Duration(days: x + y * 7));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getUiImage(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return CustomPaint(
            painter: CalenderPainter(
              spaceRow: widget.spaceRow,
              spaceColumn: widget.spaceColumn,
              normalDayColor: widget.normalDayColor,
              selectedDayColor: widget.selectedDayColor,
              saturdayColor: widget.saturdayColor,
              sundayColor: widget.sundayColor,
              otherDayColor: widget.otherDayColor,
              selectedDate: widget.selectedDate,
              sleepForecastLevelPics: sleepForecastLevelPics,
            ),
            child: GestureDetector(
              onTap: () {
                print('tapped');
              },
              onTapDown: (details) {
                final DateTime date = _getDateOnTap(details, context);
                print("down $date");
              },
              onTapUp: (details) {
                print("up ${details.localPosition}");
              },
              onTapCancel: () {
                print("cancel");
              },
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
