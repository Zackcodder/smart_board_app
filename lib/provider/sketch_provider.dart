import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_board_app/models/sketch_model.dart';
import 'package:smart_board_app/screens/home.dart';

class SketchProvider extends ChangeNotifier {
  List<Sketch> sketches = [];
  List<List<Sketch>> undoStack = [];
  List<List<Sketch>> redoStack = [];
  Color selectedColor = Colors.black;
  double strokeWidth = 3.0;
  double eraserSize = 3.0;

  Path currentPath = Path();
  bool isEraserActive = false;

  ///background color
  Color _backgroundColor = Colors.white;
  Color get backgroundColor => _backgroundColor;

  final Color _eraserColor = Colors.white;
  Color get eraserColor => _eraserColor;

  ///background template
  String? _backgroundImage;
  String? get backgroundImage => _backgroundImage;

  ///login
  toggleLoginOption() {
    showLoginOptions = !showLoginOptions;
    notifyListeners();
  }

  toggleEraser() {
    isEraserActive = !isEraserActive;
    strokeWidth = isEraserActive ? eraserSize : 3.0;
    notifyListeners();
  }

  updateEraserSize(double size) {
    eraserSize = size;
    if (isEraserActive) {
      strokeWidth = eraserSize;
    }
    notifyListeners();
  }

  void startDrawing(Offset point) {
    currentPath = Path()..moveTo(point.dx, point.dy);
    notifyListeners();
  }


  addPoint(Offset point, {bool isErasing = false}) {
    if (sketches.isEmpty || sketches.last.points.isEmpty) {
      sketches.add(Sketch(
        points: [point],
        color: selectedColor,
        strokeWidth: strokeWidth,
        isErasing: isErasing,
        type: SketchType.scribble,
        paths: Path(),
      ));
    } else {
      sketches.last.points.add(point);
    }
    // Notify listeners every 3 points added to reduce UI lag
  if (sketches.last.points.length % 2 == 0) {
    notifyListeners();
  }
  }

  void endDrawing() {
    sketches.add(Sketch(
        points: [],
        color: selectedColor,
        strokeWidth: strokeWidth,
        isErasing: isEraserActive,
        type: SketchType.line,
        filled: true,
        paths: Path()
        // sides: 0,
        ));
    notifyListeners();
  }

  void updateColor(Color color) {
    selectedColor = color;
    notifyListeners();
  }

  void updateStrokeWidth(double width) {
    strokeWidth = width;
    notifyListeners();
  }

  void clearCanvas() {
    strokeWidth = 3.0;
    isEraserActive = false;
    redoStack.clear();
    undoStack.add(List.from(sketches));
    sketches.clear();
    notifyListeners();
  }

  void addSketch(Sketch sketch) {
    undoStack.add(List.from(sketches));
    redoStack
        .clear(); // Clear the redo stack whenever a new action is performed
    sketches.add(sketch);
    notifyListeners();
  }

// Add a method to update the sketches
  updateSketches(List<Sketch> sketches) {
    undoStack.add(List.from(sketches)); // Save current state to undo stack
    sketches = sketches;
    redoStack.clear(); // Clear redo stack
    notifyListeners();
  }

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

  ///background color
  void setBackgroundColor(Color color) {
    _backgroundColor = color;
    strokeWidth = 3.0;
    isEraserActive = false;
    print(color.toString());
    clearCachedImage();
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
    _backgroundColor = Colors.transparent;
    notifyListeners();
  }

  // clear the cached image when needed
  void clearCachedImage() {
    _cachedImage = null;
    isEraserActive = false;
    strokeWidth = 3.0;
    notifyListeners();
  }
}
