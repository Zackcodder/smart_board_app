import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_board_app/models/sketch_data_provider.dart';
import 'package:smart_board_app/models/sketch_model.dart';
import 'package:smart_board_app/screens/newHome.dart';

class SketchProvider extends ChangeNotifier {
  ///background color
  Color _backgroundColor = Colors.white;
  Color get backgroundColor => _backgroundColor;

  ///background template
  String? _backgroundImage;
  String? get backgroundImage => _backgroundImage;

  ///background color
  void setBackgroundColor(Color color) {
    _backgroundColor = color;
    clearCachedImage(color);
    notifyListeners();
  }

  ///handling the background image
  ///when it is selected
  ui.Image? _cachedImage;

  ui.Image? get cachedImage => _cachedImage;

  Future<void> loadImage(String imagePath) async {
    final ByteData data = await rootBundle.load(imagePath); // Load from assets
    final Uint8List bytes =
        data.buffer.asUint8List(); // Convert directly to Uint8List
    final ui.Codec codec = await ui.instantiateImageCodec(bytes);
    final ui.FrameInfo frame = await codec.getNextFrame();
    _cachedImage = frame.image;
    // isEraserActive = false;
    // strokeWidth = 3.0;
    // _backgroundColor = Colors.transparent;
    notifyListeners();
  }

  // clear the cached image when needed
  void clearCachedImage(Color color) {
    _backgroundColor = color;
    _cachedImage = null;
    notifyListeners();
  }

  ///drawing mode
  DrawingMode _mode = DrawingMode.pencil;
  DrawingMode get mode => _mode;

  set mode(DrawingMode value) {
    _mode = value;
    notifyListeners();
  }

  ///sketech
  List<Sketch> _sketches = [];
  List<Sketch> get sketches => _sketches;
  set sketches(List<Sketch> value) {
    _sketches = value;
    notifyListeners();
  }

  Sketch? _sketch;
  Sketch? get sketch => _sketch;

  set sketch(Sketch? value) {
    setOption(setAllTo: false);
    _sketch = value;
    _sketches = sketches;
    notifyListeners();
  }

  //stroke color
  Color selectedColor = Colors.black;
  Color eraserColor = Colors.red;
  void updateColor(Color color) {
    selectedColor = color;
    notifyListeners();
  }

  ///stroke width
  double strokeWidth = 3.0;
  void updateStrokeWidth(double width) {
    strokeWidth = width;
    notifyListeners();
  }

  ///eraser size
  double eraserSize = 3.0;
  bool isEraserActive = false;

  toggleNewEraser(bool active) {
    isEraserActive = active;
    notifyListeners();
  }

  updateEraserSize(double width) {
    eraserSize = width;
    notifyListeners();
  }

  ///clear cnavas
  clearCanvas() {
    isEraserActive = false;
    sketches.clear();
    notifyListeners();
  }

  ///background color
  // Color _backgroundColor = Colors.white;
  // Color get backgroundColor => _backgroundColor;
  // setBackgroundColor(Color color) {
  //   _backgroundColor = color;
  //   notifyListeners();
  // }

  int _sides = 3;
  int get sides => _sides;

  set sides(int value) {
    _sides = value;
    notifyListeners();
  }

  bool _filled = false;
  bool get filled => _filled;

  set filled(bool value) {
    _filled = value;
    notifyListeners();
  }

  ///new features
  ///drawing of 
}
