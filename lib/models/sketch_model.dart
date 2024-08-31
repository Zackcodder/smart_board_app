import 'package:flutter/material.dart';
import 'package:smart_board_app/models/sketch_data_provider.dart';

class Sketch {
  final Path paths;
  final List<Offset> points;
  final Color color;
  final double strokeWidth;
  // final double size;
  final SketchType type;
  bool isErasing;
  final bool filled;
  final int sides;

  Sketch({
    required this.points,
    required this.paths,
    required this.strokeWidth,
    required this.color,
    this.type = SketchType.scribble,
    this.filled = false,
    required this.isErasing,
    this.sides = 3,
    // required this.size,
  });

  factory Sketch.fromDrawingMode(
    Sketch sketch,
    DrawingMode drawingMode,
    bool filled,
  ) {
    return Sketch(
      points: sketch.points,
      color: sketch.color,
      paths: sketch.paths,
      isErasing: sketch.isErasing,
      strokeWidth: sketch.strokeWidth,

      filled: drawingMode == DrawingMode.line ||
              drawingMode == DrawingMode.pencil ||
              drawingMode == DrawingMode.eraser
          ? false
          : filled,
      sides: sketch.sides,
      type: () {
        switch (drawingMode) {
          case DrawingMode.eraser:
          case DrawingMode.pencil:
            return SketchType.scribble;
          case DrawingMode.line:
            return SketchType.line;
          case DrawingMode.square:
            return SketchType.square;
          case DrawingMode.circle:
            return SketchType.circle;
          case DrawingMode.polygon:
            return SketchType.polygon;
          default:
            return SketchType.scribble;
        }
      }(),
    );
  }

  Map<String, dynamic> toJson() {
    List<Map> pointsMap = points.map((e) => {'dx': e.dx, 'dy': e.dy}).toList();
    return {
      'paths': paths,
      'points': pointsMap,
      'color': color.toHex(),
      // 'size': size,
      'filled': filled,
      'strokeWidth': strokeWidth,
      'isErasing': isErasing,
      'type': type.toRegularString(),
      'sides': sides,
    };
  }

  factory Sketch.fromJson(Map<String, dynamic> json) {
    List<Offset> points =
        (json['points'] as List).map((e) => Offset(e['dx'], e['dy'])).toList();
    return Sketch(
      paths: json['paths'],
      points: points,
      color: (json['color'] as String).toColor(),
      // size: json['size'],
      strokeWidth: json['strokeWidth'],
      isErasing: json['isErasing'],
      filled: json['filled'],
      type: (json['type'] as String).toSketchTypeEnum(),
      sides: json['sides'],
    );
  }
}

enum SketchType {
  scribble,
  square,
  circle,
  polygon,
  line,
  pencil,
  eraser
}

extension SketchTypeX on SketchType {
  String toRegularString() => toString().split('.')[1];
}

extension SketchTypeExtension on String {
  SketchType toSketchTypeEnum() =>
      SketchType.values.firstWhere((e) => e.toString() == 'SketchType.$this');
}

extension ColorExtension on String {
  Color toColor() {
    var hexColor = replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    if (hexColor.length == 8) {
      return Color(int.parse('0x$hexColor'));
    } else {
      return Colors.red;
    }
  }
}

extension ColorExtensionX on Color {
  String toHex() => '#${value.toRadixString(16).substring(2, 8)}';
}
