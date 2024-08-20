import 'dart:math' as math;
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_board_app/models/drawing_model.dart';
import 'package:smart_board_app/models/sketch_model.dart';
import 'package:smart_board_app/provider/new_provider.dart';
import 'package:smart_board_app/provider/sketch_provider.dart';
import 'package:smart_board_app/screens/home.dart';

class NewDrawingCanvas extends StatefulWidget {
  final double height;
  final double width;
  // final GlobalKey canvasGlobalKey;

  const NewDrawingCanvas({
    super.key,
    required this.height,
    required this.width,
    // required this.canvasGlobalKey,
  });

  @override
  State<NewDrawingCanvas> createState() => _NewDrawingCanvasState();
}

class _NewDrawingCanvasState extends State<NewDrawingCanvas> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildAllSketches(context),
        buildCurrentPath(context),
      ],
    );
  }

  void onPointerDown(PointerDownEvent details, BuildContext context) {
    final box = context.findRenderObject() as RenderBox;
    final offset = box.globalToLocal(details.position);

    final drawingMode =
        Provider.of<AllSketchesNotifier>(context, listen: false).mode;
    final eraserSize =
        Provider.of<AllSketchesNotifier>(context, listen: false).eraserSize;
    final strokeSize =
        Provider.of<AllSketchesNotifier>(context, listen: false).strokeWidth;
    final selectedColor =
        Provider.of<AllSketchesNotifier>(context, listen: false).selectedColor;
    final polygonSides =
        Provider.of<AllSketchesNotifier>(context, listen: false).sides;
    final filled =
        Provider.of<AllSketchesNotifier>(context, listen: false).filled;
    final backGroundColor =
        Provider.of<AllSketchesNotifier>(context, listen: false)
            .backgroundColor;

    final currentSketch = Sketch.fromDrawingMode(
      Sketch(
        isErasing: Provider.of<AllSketchesNotifier>(context, listen: false).isEraserActive,
        paths: Path(),
        points: [offset],
        strokeWidth:
            drawingMode == DrawingMode.eraser ? eraserSize : strokeSize,
        color:
            drawingMode == DrawingMode.eraser ? backGroundColor : selectedColor,
        sides: polygonSides,
      ),
      drawingMode,
      filled,
    );

    Provider.of<AllSketchesNotifier>(context, listen: false).sketch =
        currentSketch;
  }

  void onPointerMove(PointerMoveEvent details, BuildContext context) {
    final box = context.findRenderObject() as RenderBox;
    final offset = box.globalToLocal(details.position);

    final currentSketchNotifier =
        Provider.of<AllSketchesNotifier>(context, listen: false);
    final drawingMode =
        Provider.of<AllSketchesNotifier>(context, listen: false).mode;
    final eraserSize =
        Provider.of<AllSketchesNotifier>(context, listen: false).eraserSize;
    final strokeSize =
        Provider.of<AllSketchesNotifier>(context, listen: false).strokeWidth;
    final selectedColor =
        Provider.of<AllSketchesNotifier>(context, listen: false).selectedColor;
    final polygonSides =
        Provider.of<AllSketchesNotifier>(context, listen: false).sides;
    final filled =
        Provider.of<AllSketchesNotifier>(context, listen: false).filled;
    final backGroundColor =
        Provider.of<AllSketchesNotifier>(context, listen: false)
            .backgroundColor;

    final points = List<Offset>.from(currentSketchNotifier.sketch?.points ?? [])
      ..add(offset);

    currentSketchNotifier.sketch = Sketch.fromDrawingMode(
      Sketch(
        isErasing: Provider.of<AllSketchesNotifier>(context, listen: false)
            .isEraserActive,
        paths: Path(),
        points: points,
        strokeWidth:
            drawingMode == DrawingMode.eraser ? eraserSize : strokeSize,
        color:
            drawingMode == DrawingMode.eraser ? backGroundColor : selectedColor,
        sides: polygonSides,
      ),
      drawingMode,
      filled,
    );
  }

  void onPointerUp(PointerUpEvent details, BuildContext context) {
//   setState(() {
//        showPencilOptions = false;
//  showBackgroundOption = false;
//  sideBackgroundImageList = false;
//  showLoginOptions = false;
//  showEraserSkider = false;
//   });
    final currentSketch =
        Provider.of<AllSketchesNotifier>(context, listen: false).sketch;

    if (currentSketch != null) {
      final allSketches =
          Provider.of<AllSketchesNotifier>(context, listen: false);
      allSketches.sketches = List<Sketch>.from(allSketches.sketches)
        ..add(currentSketch);
    }

    Provider.of<AllSketchesNotifier>(context, listen: false).sketch =
        Sketch.fromDrawingMode(
      Sketch(
        isErasing: Provider.of<AllSketchesNotifier>(context, listen: false)
            .isEraserActive,
        paths: Path(),
        points: [],
        strokeWidth:
            Provider.of<AllSketchesNotifier>(context, listen: false).mode ==
                    DrawingMode.eraser
                ? Provider.of<AllSketchesNotifier>(context, listen: false)
                    .eraserSize
                : Provider.of<AllSketchesNotifier>(context, listen: false)
                    .strokeWidth,
        color: Provider.of<AllSketchesNotifier>(context, listen: false).mode ==
                DrawingMode.eraser
            ? Colors.white
            : Provider.of<AllSketchesNotifier>(context, listen: false)
                .selectedColor,
        sides: Provider.of<AllSketchesNotifier>(context, listen: false).sides,
      ),
      Provider.of<AllSketchesNotifier>(context, listen: false).mode,
      Provider.of<AllSketchesNotifier>(context, listen: false).filled,
    );
  }

  Widget buildAllSketches(BuildContext context) {
    final sketchProvider = Provider.of<SketchProvider>(context);
    return Consumer<AllSketchesNotifier>(
      builder: (context, allSketches, _) {
        return SizedBox(
          height: widget.height,
          width: widget.width,
          child: RepaintBoundary(
            // key: canvasGlobalKey,
            child: Container(
              width: double.maxFinite,
              height: double.maxFinite,
              decoration: BoxDecoration(
                color: sketchProvider.backgroundColor,
                image: sketchProvider.backgroundImage != null
                    ? DecorationImage(
                        image: AssetImage(sketchProvider.backgroundImage!),
                        fit: BoxFit.fill,
                      )
                    : null,
              ),
              child: CustomPaint(
                painter: SketchPainter(
                  sketches: allSketches.sketches,
                  backgroundImage: sketchProvider.cachedImage,
                  backgroundColor: sketchProvider.backgroundColor,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildCurrentPath(BuildContext context) {
    final sketchProvider = Provider.of<SketchProvider>(context);
    final newSketchProvider = Provider.of<AllSketchesNotifier>(context);
    return Listener(
      onPointerDown: (details) => onPointerDown(details, context),
      onPointerMove: (details) => onPointerMove(details, context),
      onPointerUp: (details) => onPointerUp(details, context),
      child: Consumer<AllSketchesNotifier>(
        builder: (context, currentSketchNotifier, _) {
          final currentSketch = currentSketchNotifier.sketch;
          return SizedBox(
            width: double.maxFinite,
            height: double.maxFinite,
            child: CustomPaint(
              painter: SketchPainter(
                backgroundImage: newSketchProvider.cachedImage,
                backgroundColor: newSketchProvider.backgroundColor,
                sketches: currentSketch != null ? [currentSketch] : [],
              ),
            ),
          );
        },
      ),
    );
  }
}

class SketchPainter extends CustomPainter {
  final List<Sketch> sketches;
  final Color backgroundColor;
  final ui.Image? backgroundImage;

  const SketchPainter({
    Key? key,
    this.backgroundImage,
    required this.backgroundColor,
    required this.sketches,
  });

  @override
  void paint(Canvas canvas, Size size) {
    //background image
    if (backgroundImage != null) {
      canvas.drawImageRect(
        backgroundImage!,
        Rect.fromLTWH(
          0,
          0,
          backgroundImage!.width.toDouble(),
          backgroundImage!.height.toDouble(),
        ),
        Rect.fromLTWH(0, 0, size.width, size.height),
        Paint(),
      );
    }
    for (Sketch sketch in sketches) {
      Paint paint = Paint();
      if (!sketch.isErasing) {
        paint.color = sketch.color;
      } else {
        paint
          ..color =
              backgroundImage == null ? backgroundColor : Colors.transparent
          ..blendMode =
              backgroundImage == null ? BlendMode.srcOver : BlendMode.clear;
      }

      final points = sketch.points;
      if (points.isEmpty) return;

      final path = Path();

      path.moveTo(points[0].dx, points[0].dy);
      if (points.length < 2) {
        // If the path only has one line, draw a dot.
        path.addOval(
          Rect.fromCircle(
            center: Offset(points[0].dx, points[0].dy),
            radius: 1,
          ),
        );
      }

      for (int i = 1; i < points.length - 1; ++i) {
        final p0 = points[i];
        final p1 = points[i + 1];
        path.quadraticBezierTo(
          p0.dx,
          p0.dy,
          (p0.dx + p1.dx) / 2,
          (p0.dy + p1.dy) / 2,
        );
      }

      paint
        ..color = sketch.color
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..strokeWidth = sketch.strokeWidth;

      // if (!sketch.filled) {
      //   paint.style = PaintingStyle.stroke;
      //   paint.strokeWidth = sketch.strokeWidth;
      // }

      // define first and last points for convenience
      Offset firstPoint = sketch.points.first;
      Offset lastPoint = sketch.points.last;

      // create rect to use rectangle and circle
      Rect rect = Rect.fromPoints(firstPoint, lastPoint);

      // Calculate center point from the first and last points
      Offset centerPoint = (firstPoint / 2) + (lastPoint / 2);

      // Calculate path's radius from the first and last points
      double radius = (firstPoint - lastPoint).distance / 2;

      if (sketch.type == SketchType.scribble) {
        canvas.drawPath(path, paint);
      } else if (sketch.type == SketchType.square) {
        canvas.drawRRect(
          RRect.fromRectAndRadius(rect, const Radius.circular(5)),
          paint,
        );
      } else if (sketch.type == SketchType.line) {
        canvas.drawLine(firstPoint, lastPoint, paint);
      } else if (sketch.type == SketchType.circle) {
        canvas.drawOval(rect, paint);
        // Uncomment this line if you need a PERFECT CIRCLE
        // canvas.drawCircle(centerPoint, radius , paint);
      } else if (sketch.type == SketchType.polygon) {
        Path polygonPath = Path();
        int sides = sketch.sides;
        var angle = (math.pi * 2) / sides;

        double radian = 0.0;

        Offset startPoint =
            Offset(radius * math.cos(radian), radius * math.sin(radian));

        polygonPath.moveTo(
          startPoint.dx + centerPoint.dx,
          startPoint.dy + centerPoint.dy,
        );
        for (int i = 1; i <= sides; i++) {
          double x = radius * math.cos(radian + angle * i) + centerPoint.dx;
          double y = radius * math.sin(radian + angle * i) + centerPoint.dy;
          polygonPath.lineTo(x, y);
        }
        polygonPath.close();
        canvas.drawPath(polygonPath, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant SketchPainter oldDelegate) {
    return oldDelegate.sketches != sketches;
  }
}
