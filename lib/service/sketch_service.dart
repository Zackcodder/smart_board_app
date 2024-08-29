import 'package:flutter/material.dart';
import 'package:smart_board_app/models/sketch_data_provider.dart';
import 'package:smart_board_app/models/storage_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SketchDataService with ChangeNotifier {
  static const String sketchesKey = 'sketches';
  final StorageProvider storageProvider;

  SketchDataService({required this.storageProvider});

  List<SketchData> getAllSketches() {
    return List<SketchData>.from(
      storageProvider.all(sketchesKey).map(
        (json) => SketchData.fromJson(json),
      ),
    );
  }

  SketchData? getSketchById(String id) {
    try {
      final json = storageProvider.index(sketchesKey, id);
      return json != null ? SketchData.fromJson(json) : null;
    } catch (e) {
      return null;
    }
  }

  void createSketch(SketchData sketchData) {
    final allSketches = getAllSketches();
    allSketches.add(sketchData);
    storageProvider.set(
      sketchesKey,
      allSketches.map((sketch) => sketch.toJson()).toList(),
    );
    notifyListeners();
  }

  void updateSketch(String id, SketchData updatedSketch) {
    final allSketches = getAllSketches();
    final index = allSketches.indexWhere((sketch) => sketch.id == id);
    if (index != -1) {
      allSketches[index] = updatedSketch;
      storageProvider.set(
        sketchesKey,
        allSketches.map((sketch) => sketch.toJson()).toList(),
      );
      notifyListeners();
    }
  }

  void deleteSketch(String id) {
    final allSketches = getAllSketches();
    allSketches.removeWhere((sketch) => sketch.id == id);
    storageProvider.set(
      sketchesKey,
      allSketches.map((sketch) => sketch.toJson()).toList(),
    );
    notifyListeners();
  }

  void clearAllSketches() {
    storageProvider.clear(sketchesKey);
    notifyListeners();
  }

  ///bing brower
  bingBrowser() async {
    final Uri url = Uri.parse("https://www.bing.com/");
    if (await launchUrl(url)) {
      return true;
    }
    return false;
  }

  ///webster
  websterBrowser() async {
    final Uri url = Uri.parse("https://www.merriam-webster.com/");
    if (await launchUrl(url)) {
      return true;
    }
    return false;
  }
  ///longman
  longmanBrowser() async {
    final Uri url = Uri.parse("https://www.ldoceonline.com/");
    if (await launchUrl(url)) {
      return true;
    }
    return false;
  }
}
