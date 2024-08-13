import 'package:flutter/material.dart' hide Image;
import 'package:provider/provider.dart';
import 'package:smart_board_app/provider/sketch_provider.dart';
import 'package:smart_board_app/screens/home.dart';

class DrawingCanvas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sketchProvider = Provider.of<SketchProvider>(context);

    return GestureDetector(
      onPanUpdate: (details) {
        RenderBox renderBox = context.findRenderObject() as RenderBox;
        Offset localPosition = renderBox.globalToLocal(details.globalPosition);
        sketchProvider.addPoint(localPosition);
        showPencilOptions = false;
        showBackgroundOption = false;
        sideBackgroundImageList = false;
        // sketchProvider.eraserColor = sketchProvider.backgroundColor;
      },
      onPanEnd: (details) {
        sketchProvider.endDrawing();
        context.read<SketchProvider>().updateSketches(sketchProvider.sketches);
      },
      child: CustomPaint(
        painter: _DrawingPainter(
          sketchProvider,
          sketchProvider.isEraserActive
              ? sketchProvider.backgroundColor
              : sketchProvider.backgroundColor,
          sketchProvider.backgroundImage,
        ),
        size: Size.infinite,
      ),
    );
  }
}

///
class _DrawingPainter extends CustomPainter {
  final SketchProvider sketchProvider;
  final Color backgroundColor;
  final String? backgroundImage;

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
    final image = AssetImage(backgroundImage!);
    final imageStream = image.resolve(const ImageConfiguration());

    imageStream.addListener(ImageStreamListener((ImageInfo info, bool _) {
      final srcRect = Rect.fromLTWH(
          0, 0, info.image.width.toDouble(), info.image.height.toDouble());
      final dstRect = Rect.fromLTWH(0, 0, size.width, size.height);
      canvas.drawImageRect(info.image, srcRect, dstRect, paint);
    }));
  } else {
    // Draw the background color if no image is set
    final backgroundPaint = Paint()..color = backgroundColor;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), backgroundPaint);
  }
    // if (backgroundImage != null) {
    //   final paint = Paint();
    //   final image = AssetImage(backgroundImage!);
    //   final imageStream = image.resolve(const ImageConfiguration());

    //   imageStream.addListener(ImageStreamListener((ImageInfo info, bool _) {
    //     // Scale and draw the image to fit the canvas
    //     final srcRect = Rect.fromLTWH(
    //         0, 0, info.image.width.toDouble(), info.image.height.toDouble());
    //     final dstRect = Rect.fromLTWH(0, 0, size.width, size.height);
    //     canvas.drawImageRect(info.image, srcRect, dstRect, paint);
    //   }));
    // } else {
    //   final backgroundPaint = Paint()..color = backgroundColor;
    //   canvas.drawRect(
    //       Rect.fromLTWH(0, 0, size.width, size.height), backgroundPaint);
    // }

    for (var sketch in sketchProvider.sketches) {
      Paint paint = Paint()
        ..color = sketch.color
        ..strokeWidth = sketch.strokeWidth
        ..isAntiAlias = true
        ..strokeCap = StrokeCap.round;
      // ..style = PaintingStyle.fill;
      canvas.drawPath(sketch.paths, paint);

      for (int i = 0; i < sketch.points.length - 1; i++) {
        canvas.drawLine(sketch.points[i], sketch.points[i + 1], paint);
      }
      if (sketch.color != Colors.transparent) {
    canvas.drawPath(sketch.paths, paint);
  }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  ///
}
