import 'dart:ui';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter_image_converter/flutter_image_converter.dart';
import 'package:smart_board_app/models/drawing_model.dart';
import 'package:smart_board_app/models/sketch_data_provider.dart';
import 'package:smart_board_app/models/sketch_model.dart';
import 'package:smart_board_app/service/sketch_service.dart';

class NewSketchProvider with ChangeNotifier {
  late SketchDataService sketchDataService;
  String? id;
  bool loading = true;

  Color selectedColor = Colors.black;
  double strokeSize = 10;
  double eraserSize = 30;
  DrawingMode drawingMode = DrawingMode.pencil;
  bool filled = false;
  int polygonSides = 3;
  Image? backgroundImage;
  String title = "Untitled";
  List<Sketch> allSketches = [];

  

  void load(SketchData sketch) async {
    selectedColor = sketch.selectedColor;
    strokeSize = sketch.strokeSize;
    eraserSize = sketch.eraserSize;
    filled = sketch.filled;
    polygonSides = sketch.polygonSides;
    backgroundImage = await sketch.backgroundImage?.uiImage;
    title = sketch.title;
    allSketches = sketch.allSketches;
    notifyListeners();
  }

  void save(BuildContext context) async {
    if (title == "Untitled") {
      var named = await showTitleDialog(context);
      if (!named) return;
    }

    var background =
        backgroundImage != null ? await backgroundImage!.pngUint8List : null;

    final sketchData = SketchData(
      id: id ?? DateTime.now().toIso8601String(),
      selectedColor: selectedColor,
      strokeSize: strokeSize,
      eraserSize: eraserSize,
      drawingMode: drawingMode,
      filled: filled,
      polygonSides: polygonSides,
      backgroundImage: background,
      title: title,
      allSketches: allSketches,
    );

    if (id != null) {
      sketchDataService.updateSketch(sketchData.id, sketchData);
    } else {
      sketchDataService.createSketch(sketchData);
      id = sketchData.id;
    }

    notifyListeners();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Sketch data saved!')));
  }

  Future<bool> showTitleDialog(BuildContext context) async {
    TextEditingController titleController = TextEditingController(text: title);
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter Sketch Title'),
        content: TextField(
          controller: titleController,
          decoration: const InputDecoration(
            hintText: 'Sketch Title',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              title = titleController.text;
              Navigator.of(context).pop(true);
            },
            child: const Text('Save'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}
