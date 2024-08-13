
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:smart_board_app/models/drawing_model.dart';
import 'package:smart_board_app/models/sketch_model.dart';

class SketchData with ChangeNotifier {
  String _id;
  Color _selectedColor;
  // double _strokeSize;
  double _eraserSize;
  DrawingMode _drawingMode;
  // bool _filled;
  // int _polygonSides;
  Uint8List? _backgroundImage;
  // String _title;
  List<Sketch> _allSketches;

  SketchData({
    required String id,
    required Color selectedColor,
    required double strokeWidth,
    required double eraserSize,
    required DrawingMode drawingMode,
    // required bool filled,
    // required int polygonSides,
    Uint8List? backgroundImage,
    // required String title,
    required List<Sketch> allSketches,
  })  : _id = id,
        _selectedColor = selectedColor,
        _strokeWidth = strokeWidth,
        _eraserSize = eraserSize,
        _drawingMode = drawingMode,
        // _filled = filled,
        // _polygonSides = polygonSides,
        _backgroundImage = backgroundImage,
        // _title = title,
        _allSketches = allSketches;

  SketchData.create({
    required Color selectedColor,
    required double strokeWidth,
    required double eraserSize,
    required DrawingMode drawingMode,
    // required bool filled,
    // required int polygonSides,
    Uint8List? backgroundImage,
    // required String title,
    required List<Sketch> allSketches,
  })  : _id = DateTime.now().toIso8601String(),
        _selectedColor = selectedColor,
        _strokeWidth = strokeWidth,
        _eraserSize = eraserSize,
        _drawingMode = drawingMode,
        // _filled = filled,
        // _polygonSides = polygonSides,
        _backgroundImage = backgroundImage,
        // _title = title,
        _allSketches = allSketches;

  // Getters
  String get id => _id;
  Color get selectedColor => _selectedColor;
  // double get strokeSize => _strokeSize;
  double get eraserSize => _eraserSize;
  DrawingMode get drawingMode => _drawingMode;
  // bool get filled => _filled;
  // int get polygonSides => _polygonSides;
  Uint8List? get backgroundImage => _backgroundImage;
  // String get title => _title;
  List<Sketch> get allSketches => _allSketches;
  
  double _strokeWidth;
  double get strokeWidth => _strokeWidth;
  // Setters with notifyListeners
  set selectedColor(Color newColor) {
    _selectedColor = newColor;
    notifyListeners();
  }

  set strokeSize(double newSize) {
    _strokeWidth = newSize;
    notifyListeners();
  }

  set eraserSize(double newSize) {
    _eraserSize = newSize;
    notifyListeners();
  }

  set drawingMode(DrawingMode newMode) {
    _drawingMode = newMode;
    notifyListeners();
  }

  // set filled(bool isFilled) {
  //   _filled = isFilled;
  //   notifyListeners();
  // }

  // set polygonSides(int newSides) {
  //   _polygonSides = newSides;
  //   notifyListeners();
  // }

  set backgroundImage(Uint8List? newImage) {
    _backgroundImage = newImage;
    notifyListeners();
  }

  // set title(String newTitle) {
  //   _title = newTitle;
  //   notifyListeners();
  // }

  set allSketches(List<Sketch> newSketches) {
    _allSketches = newSketches;
    notifyListeners();
  }

  // Factory constructor for creating a SketchData instance from JSON
  factory SketchData.fromJson(Map<String, dynamic> json) {
    var sketchesFromJson = json['allSketches'] as List;
    List<Sketch> sketchesList =
        sketchesFromJson.map((sketch) => Sketch.fromJson(sketch)).toList();

    return SketchData(
      id: json['id'],
      selectedColor: Color(json['selectedColor']),
      strokeWidth: json['strokeWidth'],
      eraserSize: json['eraserSize'],
      drawingMode: DrawingMode.values[json['drawingMode']],
      // filled: json['filled'],
      // polygonSides: json['polygonSides'],
      backgroundImage: json['backgroundImage'] != null
          ? Uint8List.fromList(List<int>.from(json['backgroundImage']))
          : null,
      // title: json['title'],
      allSketches: sketchesList,
    );
  }

  // Convert SketchData to JSON
  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> sketchesToJson =
        _allSketches.map((sketch) => sketch.toJson()).toList();
    return {
      'id': _id,
      'selectedColor': _selectedColor.value,
      'strokeWidth': _strokeWidth,
      'eraserSize': _eraserSize,
      'drawingMode': _drawingMode.index,
      // 'filled': _filled,
      // 'polygonSides': _polygonSides,
      'backgroundImage': _backgroundImage,
      // 'title': _title,
      'allSketches': sketchesToJson,
    };
  }
}
