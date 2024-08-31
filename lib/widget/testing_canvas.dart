import 'dart:math' as math;
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_board_app/models/sketch_data_provider.dart';
import 'package:smart_board_app/models/sketch_model.dart';
import 'package:smart_board_app/provider/sketch_provider.dart';

import '../screens/newhome.dart';

class NewDrawingCanvas extends StatefulWidget {
  final double height;
  final double width;

  const NewDrawingCanvas({
    super.key,
    required this.height,
    required this.width,
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
    showPencilOptions.value = false;
    final box = context.findRenderObject() as RenderBox;
    final offset = box.globalToLocal(details.position);

    final drawingMode =
        Provider.of<SketchProvider>(context, listen: false).mode;
    final eraserSize =
        Provider.of<SketchProvider>(context, listen: false).eraserSize;
    final strokeSize =
        Provider.of<SketchProvider>(context, listen: false).strokeWidth;
    final selectedColor =
        Provider.of<SketchProvider>(context, listen: false).selectedColor;
    final polygonSides =
        Provider.of<SketchProvider>(context, listen: false).sides;
    final filled = Provider.of<SketchProvider>(context, listen: false).filled;

    final currentSketch = Sketch.fromDrawingMode(
      Sketch(
        isErasing:
            Provider.of<SketchProvider>(context, listen: false).isEraserActive,
        paths: Path(),
        points: [offset],
        strokeWidth:
            drawingMode == DrawingMode.eraser ? eraserSize : strokeSize,
        color: drawingMode == DrawingMode.eraser
            ? Colors.transparent
            : selectedColor,
        sides: polygonSides,
      ),
      drawingMode,
      filled,
    );

    Provider.of<SketchProvider>(context, listen: false).sketch = currentSketch;
  }

  void onPointerMove(PointerMoveEvent details, BuildContext context) {
    final box = context.findRenderObject() as RenderBox;
    final offset = box.globalToLocal(details.position);

    final currentSketchNotifier =
        Provider.of<SketchProvider>(context, listen: false);
    final drawingMode =
        Provider.of<SketchProvider>(context, listen: false).mode;
    final eraserSize =
        Provider.of<SketchProvider>(context, listen: false).eraserSize;
    final strokeSize =
        Provider.of<SketchProvider>(context, listen: false).strokeWidth;
    final selectedColor =
        Provider.of<SketchProvider>(context, listen: false).selectedColor;
    final polygonSides =
        Provider.of<SketchProvider>(context, listen: false).sides;
    final filled = Provider.of<SketchProvider>(context, listen: false).filled;

    final points = List<Offset>.from(currentSketchNotifier.sketch?.points ?? [])
      ..add(offset);

    currentSketchNotifier.sketch = Sketch.fromDrawingMode(
      Sketch(
        isErasing:
            Provider.of<SketchProvider>(context, listen: false).isEraserActive,
        paths: Path(),
        points: points,
        strokeWidth:
            drawingMode == DrawingMode.eraser ? eraserSize : strokeSize,
        color: drawingMode == DrawingMode.eraser
            ? Colors.transparent
            : selectedColor,
        sides: polygonSides,
      ),
      drawingMode,
      filled,
    );
  }

  void onPointerUp(PointerUpEvent details, BuildContext context) {
    final currentSketch =
        Provider.of<SketchProvider>(context, listen: false).sketch;

    if (currentSketch != null) {
      final allSketches = Provider.of<SketchProvider>(context, listen: false);
      allSketches.sketches = List<Sketch>.from(allSketches.sketches)
        ..add(currentSketch);
    }
    Provider.of<SketchProvider>(context, listen: false).sketch =
        Sketch.fromDrawingMode(
      Sketch(
        isErasing:
            Provider.of<SketchProvider>(context, listen: false).isEraserActive,
        paths: Path(),
        points: [],
        strokeWidth: Provider.of<SketchProvider>(context, listen: false).mode ==
                DrawingMode.eraser
            ? Provider.of<SketchProvider>(context, listen: false).eraserSize
            : Provider.of<SketchProvider>(context, listen: false).strokeWidth,
        color:
            Provider.of<SketchProvider>(context, listen: false).selectedColor,
        sides: Provider.of<SketchProvider>(context, listen: false).sides,
      ),
      Provider.of<SketchProvider>(context, listen: false).mode,
      Provider.of<SketchProvider>(context, listen: false).filled,
    );
  }

  Widget buildAllSketches(BuildContext context) {
    final sketchProvider = Provider.of<SketchProvider>(context);
    return Consumer<SketchProvider>(
      builder: (context, allSketches, _) {
        return SizedBox(
          height: widget.height,
          width: widget.width,
          child: CustomPaint(
            painter: SketchPainter(
              sketches: allSketches.sketches,
              backgroundImage: sketchProvider.cachedImage,
              backgroundColor: sketchProvider.backgroundColor,
              setBackgroundHere: true,
            ),
          ),
        );
      },
    );
  }

  Widget buildCurrentPath(BuildContext context) {
    final newSketchProvider = Provider.of<SketchProvider>(context);
    return Listener(
      onPointerDown: (details) => onPointerDown(details, context),
      onPointerMove: (details) => onPointerMove(details, context),
      onPointerUp: (details) => onPointerUp(details, context),
      child: Consumer<SketchProvider>(
        builder: (context, currentSketchNotifier, _) {
          final currentSketch = currentSketchNotifier.sketch;
          return SizedBox(
            width: double.maxFinite,
            height: double.maxFinite,
            child: CustomPaint(
              painter: SketchPainter(
                backgroundColor: newSketchProvider.backgroundColor,
                sketches: currentSketch != null ? [currentSketch] : [],
                setBackgroundHere: false,
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
  final bool setBackgroundHere;

  const SketchPainter({
    Key? key,
    this.backgroundImage,
    required this.backgroundColor,
    required this.sketches,
    required this.setBackgroundHere,
  });

  @override
  void paint(Canvas canvas, Size size) {
    ///for backgorund inmage and color
    if (setBackgroundHere) {
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
      } else {
        final backgroundPaint = Paint()..color = backgroundColor;
        canvas.drawRect(
            Rect.fromLTWH(0, 0, size.width, size.height), backgroundPaint);
      }

      canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), Paint());
      canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));
    }

    for (Sketch sketch in sketches) {
      Paint paint = Paint();

      if (!sketch.isErasing ) {
        paint
          ..color = sketch.color
          ..blendMode = BlendMode.srcOver;
      } else {
        paint
        ..strokeWidth = sketch.strokeWidth
        ..blendMode = BlendMode.clear;
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
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..isAntiAlias = false
        ..strokeWidth = sketch.strokeWidth;

        if (!sketch.filled) {
        paint.style = PaintingStyle.stroke;
        paint.strokeWidth = sketch.strokeWidth;
      }

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
    if (setBackgroundHere) canvas.restore();
  }

  @override
  bool shouldRepaint(covariant SketchPainter oldDelegate) {
    return oldDelegate.sketches != sketches ||
        oldDelegate.backgroundImage != backgroundImage ||
        oldDelegate.backgroundColor != backgroundColor;
  }
}
