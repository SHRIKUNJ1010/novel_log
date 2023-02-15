/*
* Created by Shrikunj Patel on 2/14/2023.
*/

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:novel_log/utility/color.dart';

class FoldPainter extends CustomPainter {
  //
  //offset from left and top
  late double offsetX;
  late double offsetY;

  //
  //coordinates of the selected points.
  late double x1;
  late double y1;

  //
  //coordinates of the bottom right point of the box.
  late double x2;
  late double y2;

  //
  //size of the box
  late double width;
  late double height;

  //
  //height and width for the part which is cut
  //or the height and width of the triangle which is
  //cut for both quadrilateral and triangle case
  //for quadrilateral case the triangle goes out of the
  //boundary of the shape/page/widget so it becomes
  //quadrilateral still imaginary triangle remains.
  late double dx;
  late double dy;

  //animated offset
  Offset offset;

  //constructor takes the touched point on the widget
  FoldPainter({
    this.offset = Offset.zero,
    this.offsetX = 0.0,
    this.offsetY = 0.0,
    required BuildContext context,
  });

  @override
  void paint(Canvas canvas, Size size) {
    //size of widget or page
    width = size.width;
    height = size.height;
    x1 = offset.dx * width;
    y1 = offset.dy * height;
    /*if (width > height) {
      offsetX = width - height;
      width = height;
    } else if (height > width) {
      offsetY = height - width;
      height = width;
    }*/
    /*if (width > height) {
      x1 = offset.dx * height + (width - height);
      y1 = offset.dy * height;
    } else if (height > width) {
      x1 = offset.dx * width;
      y1 = offset.dy * width + (height - width);
    } else {
      x1 = offset.dx * width;
      y1 = offset.dy * height;
    }*/
    //add offset to given point
    x1 = x1 + offsetX;
    y1 = y1 + offsetY;
    //end point of the quadrilateral shape / original widget
    x2 = width + offsetX;
    y2 = height + offsetY;

    if (x2 < x1) {
      x1 = x2 - (0.05 * x2);
    }
    if (y2 < y1) {
      y1 = y2 - (0.05 * y2);
    }

    //height width of the imaginary or folded triangle.
    dx = (sqrt(pow((y2 - y1), 2) + pow((x2 - x1), 2))) / (2 * cos(atan(((y2 - y1) / (x2 - x1))).abs()));
    dy = (sqrt(pow((y2 - y1), 2) + pow((x2 - x1), 2))) / (2 * sin(atan(((y2 - y1) / (x2 - x1))).abs()));

    var foldedPaint = Paint()
      ..color = appThemeColor[100]!
      ..strokeWidth = 2.0;

    var unfoldedPaint = Paint()
      ..color = Colors.transparent
      ..strokeWidth = 2.0;

    //Utility.printLog('x1: $x1 ,y1: $y1 ,x2: $x2 ,y2: $y2');

    //condition which separates the case of quadrilateral fold
    //from triangle fold
    if (dy == y2) {
      var unfoldedPath = Path()
        ..moveTo(offsetX, offsetY)
        ..lineTo(x2, offsetY)
        ..lineTo(x2 - dx, y2)
        ..lineTo(offsetX, y2);

      var foldedPath = Path()
        ..moveTo(x2, offsetY)
        ..lineTo(x1, y1)
        ..lineTo(x2 - dx, y2);

      canvas.drawPath(unfoldedPath, unfoldedPaint);
      canvas.drawPath(foldedPath, foldedPaint);
    }
    //condition for triangle fold
    else if (dy < y2) {
      if (dx < x2) {
        var unfoldedPath = Path()
          ..moveTo(offsetX, offsetY)
          ..lineTo(x2, offsetY)
          ..lineTo(x2, y2 - dy)
          ..lineTo(x2 - dx, y2)
          ..lineTo(offsetX, y2);

        var foldedPath = Path()
          ..moveTo(x2, y2 - dy)
          ..lineTo(x2 - dx, y2)
          ..lineTo(x1, y1);

        canvas.drawPath(unfoldedPath, unfoldedPaint);
        canvas.drawPath(foldedPath, foldedPaint);
        //folding quadrilateral on diffrent side
      } else {
        var unfoldedPath = Path()
          ..moveTo(offsetX, offsetY)
          ..lineTo(x2, offsetY)
          ..lineTo(x2, y2 - dy)
          ..lineTo(offsetX, y2 - ((dy * (dx - x2)) / dx));
        //..lineTo(offsetX, y2);

        var foldedPath = Path()
          ..moveTo(x2, y2 - dy)
          ..lineTo(offsetX, y2 - ((dy * (dx - x2)) / dx))
          ..lineTo(
            (-1) * (dy * (dx - x2) / dx) * (sin(2 * (atan(((x2 - x1) / (y2 - y1))).abs())).abs()),
            (y2 - ((dy * (dx - x2)) / dx)) - ((dy * (dx - x2) / dx) * (cos(2 * (atan(((x2 - x1) / (y2 - y1))).abs())).abs())).abs(),
          )
          ..lineTo(x1, y1);

        canvas.drawPath(unfoldedPath, unfoldedPaint);
        canvas.drawPath(foldedPath, foldedPaint);
      }
    }

    //condition for quadrilateral fold
    else if (dy > y2) {
      //same as upper condition
      if (dx < x2) {
        var unfoldedPath = Path()
          ..moveTo(offsetX, offsetY)
          ..lineTo(x2 - ((dx * (dy - y2)) / dy), offsetY)
          ..lineTo(x2 - dx, y2)
          ..lineTo(offsetX, y2);

        var foldedPath = Path()
          ..moveTo(x2 - ((dx * (dy - y2)) / dy), offsetY)
          ..lineTo(x2 - dx, y2)
          ..lineTo(x1, y1)
          ..lineTo((x2 - ((dx * (dy - y2)) / dy)) - ((dx * (dy - y2) / dy) * (cos(2 * (atan(((y2 - y1) / (x2 - x1))).abs())).abs())).abs(),
              (-1) * (dx * (dy - y2) / dy) * (sin(2 * (atan(((y2 - y1) / (x2 - x1))).abs())).abs()));

        canvas.drawPath(unfoldedPath, unfoldedPaint);
        canvas.drawPath(foldedPath, foldedPaint);
      }
      // when fold area is greater than unfolded page
      else {
        var unfoldedPath = Path()
          ..moveTo(offsetX, offsetY)
          ..lineTo(x2 - ((dx * (dy - y2)) / dy), offsetY)
          ..lineTo(offsetX, y2 - ((dy * (dx - x2)) / dx))
          ..lineTo(offsetX, y2);

        var foldedPath = Path()
          ..moveTo(x2 - ((dx * (dy - y2)) / dy), offsetY)
          ..lineTo(offsetX, y2 - ((dy * (dx - x2)) / dx))
          ..lineTo(
            (-1) * (dy * (dx - x2) / dx) * (sin(2 * (atan(((x2 - x1) / (y2 - y1))).abs())).abs()),
            (y2 - ((dy * (dx - x2)) / dx)) - ((dy * (dx - x2) / dx) * (cos(2 * (atan(((x2 - x1) / (y2 - y1))).abs())).abs())).abs(),
          )
          ..lineTo(x1, y1)
          ..lineTo((x2 - ((dx * (dy - y2)) / dy)) - ((dx * (dy - y2) / dy) * (cos(2 * (atan(((y2 - y1) / (x2 - x1))).abs())).abs())).abs(),
              (-1) * (dx * (dy - y2) / dy) * (sin(2 * (atan(((y2 - y1) / (x2 - x1))).abs())).abs()));

        canvas.drawPath(unfoldedPath, unfoldedPaint);
        canvas.drawPath(foldedPath, foldedPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
