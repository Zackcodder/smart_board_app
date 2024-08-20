import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_board_app/models/drawing_model.dart';
import 'package:smart_board_app/models/sketch_model.dart';

class SketchData {
  final String id;
  final Color selectedColor;
  final double strokeSize;
  final double eraserSize;
  final DrawingMode drawingMode;
  final bool filled;
  final int polygonSides;
  final Uint8List? backgroundImage;
  final String title;
  final List<Sketch> allSketches;

  SketchData({
    required this.id,
    required this.selectedColor,
    required this.strokeSize,
    required this.eraserSize,
    required this.drawingMode,
    required this.filled,
    required this.polygonSides,
    this.backgroundImage,
    required this.title,
    required this.allSketches,
  });

  SketchData.create({
    required this.selectedColor,
    required this.strokeSize,
    required this.eraserSize,
    required this.drawingMode,
    required this.filled,
    required this.polygonSides,
    this.backgroundImage,
    required this.title,
    required this.allSketches,
  }) : id = DateTime.now().toIso8601String();

  factory SketchData.fromJson(Map<String, dynamic> json) {
    var sketchesFromJson = json['allSketches'] as List;
    List<Sketch> sketchesList =
        sketchesFromJson.map((sketch) => Sketch.fromJson(sketch)).toList();

    return SketchData(
      id: json['id'],
      selectedColor: Color(json['selectedColor']),
      strokeSize: json['strokeSize'],
      eraserSize: json['eraserSize'],
      drawingMode: DrawingMode.values[json['drawingMode']],
      filled: json['filled'],
      polygonSides: json['polygonSides'],
      backgroundImage: json['backgroundImage'] != null
          ? Uint8List.fromList(List<int>.from(json['backgroundImage']))
          : null,
      title: json['title'],
      allSketches: sketchesList,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> sketchesToJson =
        allSketches.map((sketch) => sketch.toJson()).toList();
    return {
      'id': id,
      'selectedColor': selectedColor.value,
      'strokeSize': strokeSize,
      'eraserSize': eraserSize,
      'drawingMode': drawingMode.index,
      'filled': filled,
      'polygonSides': polygonSides,
      'backgroundImage': backgroundImage,
      'title': title,
      'allSketches': sketchesToJson,
    };
  }
}
