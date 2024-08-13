import 'package:flutter/material.dart';
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

  Color _eraserColor = Colors.white;
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
  selectedColor = isEraserActive ? backgroundColor : Colors.black;
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

  // void toggleEraser() {
  //   isEraserActive = !isEraserActive;
  //   selectedColor = isEraserActive ? backgroundColor : backgroundColor;
  //   notifyListeners();
  // }

  void startDrawing(Offset point) {
    currentPath = Path()..moveTo(point.dx, point.dy);
    notifyListeners();
  }

  void addPoint(Offset point) {
    if (sketches.isEmpty || sketches.last.points.isEmpty) {
      sketches.add(Sketch(
        points: [point],
        color: selectedColor,
        strokeWidth: strokeWidth,
        type: SketchType.scribble,
        paths: Path(),
      ));
    } else {
      sketches.last.points.add(point);
    }
    notifyListeners();
  }

  void endDrawing() {
    sketches.add(Sketch(
        points: [],
        color: selectedColor,
        strokeWidth: strokeWidth,
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
    notifyListeners();
  }

  void redo() {
    if (redoStack.isNotEmpty) {
      undoStack.add(List.from(sketches));
      sketches = redoStack.removeLast();
      notifyListeners();
    }
  }

  ///background imae / template
  void setBackgroundColor(Color color) {
    _backgroundColor = color;
    _eraserColor = color;
    _backgroundImage = null;
    selectedColor = isEraserActive ? color : Colors.black;
    notifyListeners();
  }

  void setBackgroundImage(String imagePath) {
    _backgroundImage = imagePath;
    _backgroundColor = Colors.transparent; // Set to transparent to show image
    notifyListeners();
  }
}
