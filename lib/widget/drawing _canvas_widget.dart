import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_board_app/provider/sketch_provider.dart';
import 'package:smart_board_app/screens/home.dart';

class DrawingCanvas extends StatefulWidget {
  const DrawingCanvas({super.key});

  @override
  State<DrawingCanvas> createState() => _DrawingCanvasState();
}

class _DrawingCanvasState extends State<DrawingCanvas> {
  @override
  Widget build(BuildContext context) {
    final sketchProvider = Provider.of<SketchProvider>(context);

    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
        RenderBox renderBox = context.findRenderObject() as RenderBox;
        Offset localPosition = renderBox.globalToLocal(details.globalPosition);
        sketchProvider.addPoint(localPosition,
            isErasing: sketchProvider.isEraserActive);
        showPencilOptions = false;
        showBackgroundOption = false;
        sideBackgroundImageList = false;
        });
      },
      onPanEnd: (details) {
        setState(() {
        sketchProvider.endDrawing();
        context.read<SketchProvider>().updateSketches(sketchProvider.sketches);
        });
      },
      child: CustomPaint(
        painter: _DrawingPainter(
          sketchProvider,
          sketchProvider.backgroundColor,
          sketchProvider.cachedImage,
        ),
        size: Size.infinite,
      ),
    );
  }
}

class _DrawingPainter extends CustomPainter {
  final SketchProvider sketchProvider;
  final Color backgroundColor;
  final ui.Image? backgroundImage;

  _DrawingPainter(
    this.sketchProvider,
    this.backgroundColor,
    this.backgroundImage,
  );

  @override
  void paint(Canvas canvas, Size size) {
    //background image
    if (backgroundImage != null) {
      final paint = Paint();
      final srcRect = Rect.fromLTWH(0, 0, backgroundImage!.width.toDouble(),
          backgroundImage!.height.toDouble());
      final dstRect = Rect.fromLTWH(0, 0, size.width, size.height);
      canvas.drawImageRect(backgroundImage!, srcRect, dstRect, paint);
    } else {
      // Draw the background color if no image is set
      final backgroundPaint = Paint()..color = backgroundColor;
      canvas.drawRect(
          Rect.fromLTWH(0, 0, size.width, size.height), backgroundPaint);
    }
//     canvas.save();
// canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), Paint());
canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));

    for (var sketch in sketchProvider.sketches) {
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

      paint
        ..strokeWidth = sketch.strokeWidth
        ..isAntiAlias = false
        ..strokeCap = StrokeCap.round;

      for (int i = 0; i < sketch.points.length - 1; i++) {
        canvas.drawLine(sketch.points[i], sketch.points[i + 1], paint);
      }

      canvas.drawPath(sketch.paths, paint);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}
