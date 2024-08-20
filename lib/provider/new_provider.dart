import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_board_app/models/drawing_model.dart';
import 'package:smart_board_app/models/sketch_model.dart';
// import 'package:smart_board_app/widget/testing_canvas.dart';

class AllSketchesNotifier extends ChangeNotifier {
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
    _sketch = value;
    notifyListeners();
  }

  ///background color
  Color _backgroundColor = Colors.white;
  Color get backgroundColor => _backgroundColor;
  setBackgroundColor(Color color) {
    _backgroundColor = color;
    isEraserActive = false;
    //   clearCachedImage();
    // _backgroundImage = null; // Clear the image when color is set
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
    isEraserActive = false;
    strokeWidth = 3.0;
    notifyListeners();
  }

  // clear the cached image when needed
  void clearCachedImage() {
    _cachedImage = null;
    isEraserActive = false;
    strokeWidth = 3.0;
    notifyListeners();
  }

  ///redo and undo
  List<List<Sketch>> undoStack = [];
  List<List<Sketch>> redoStack = [];
  undo() {
    if (undoStack.isNotEmpty) {
      sketches = undoStack.removeLast();
      redoStack.add(List.from(sketches));
      notifyListeners();
    }
  }

  void redo() {
    if (redoStack.isNotEmpty) {
      undoStack.add(List.from(sketches));
      sketches = redoStack.removeLast();
      notifyListeners();
    }
  }

  //stroke color
  Color selectedColor = Colors.black;
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
  final Color _eraserColor = Colors.white;
  Color get eraserColor => _eraserColor;
  bool isEraserActive = false;

  toggleEraser() {
    isEraserActive = !isEraserActive;
    strokeWidth = isEraserActive ? eraserSize : 3.0;
    selectedColor = isEraserActive ? backgroundColor : selectedColor;
    notifyListeners();
  }

  updateEraserSize(double size) {
    eraserSize = size;
    if (isEraserActive) {
      strokeWidth = eraserSize;
    }
    notifyListeners();
  }

  ///clear screren
  // clearCanvas() {
  //   sketches.clear();
  //   // _sketch = null;
  //   notifyListeners();
  // }
  clearCanvas() {
    // strokeWidth = 3.0;
    isEraserActive = false;
    redoStack.clear();
    undoStack.add(List.from(sketches));
    sketches.clear();
    notifyListeners();
  }

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
}
