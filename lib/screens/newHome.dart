import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smart_board_app/models/sketch_model.dart';
import 'package:smart_board_app/provider/new_provider.dart';
import 'package:smart_board_app/widget/backgound_feature.dart';
import 'package:smart_board_app/widget/pencil_feature.dart';
import 'package:smart_board_app/widget/testing_canvas.dart';

ValueNotifier<bool> showPencilOptions = ValueNotifier(false);
ValueNotifier<bool> showBackgroundOption = ValueNotifier<bool>(false);
ValueNotifier<bool> sideBackgroundImageList = ValueNotifier<bool>(false);
ValueNotifier<bool> showLoginOptions = ValueNotifier<bool>(false);
ValueNotifier<bool> showEraserSlider = ValueNotifier<bool>(false);

void setOption(
    {ValueNotifier<bool>? targetNotifier, bool? value, bool? setAllTo}) {
  if (setAllTo != null) {
    showPencilOptions.value = setAllTo;
    showBackgroundOption.value = setAllTo;
    sideBackgroundImageList.value = setAllTo;
    showLoginOptions.value = setAllTo;
    showEraserSlider.value = setAllTo;
    return;
  }

  if (targetNotifier != null && value != null) {
    targetNotifier.value = value;
    if (value == true) {
      if (targetNotifier != showPencilOptions) showPencilOptions.value = false;
      if (targetNotifier != showBackgroundOption) {
        showBackgroundOption.value = false;
      }
      if (targetNotifier != showLoginOptions) showLoginOptions.value = false;
      if (targetNotifier != showEraserSlider) showEraserSlider.value = false;
    }
  }
}

class NewHome extends StatefulWidget {
  const NewHome({super.key});

  @override
  State<NewHome> createState() => _NewHomeState();
}

class _NewHomeState extends State<NewHome> {
  late final _UndoRedoStack undoRedo;
  @override
  void initState() {
    undoRedo = _UndoRedoStack(context.read<AllSketchesNotifier>());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AllSketchesNotifier>(
        builder: (context, sketchProvider, _) {
          return Stack(
            children: [
              SizedBox(
                width: double.maxFinite,
                height: double.maxFinite,
                child: NewDrawingCanvas(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - kToolbarHeight,
                ),
              ),

              //button button options
              Positioned(
                left: 400,
                right: 10,
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: const Icon(
                          FontAwesomeIcons.pencil,
                          size: 20,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setOption(
                              targetNotifier: showPencilOptions,
                              value: !showPencilOptions.value);
                          sketchProvider.toggleEraser(false);
                        },
                      ),

                      ///eraser for canvas
                      IconButton(
                        icon: const Icon(
                          FontAwesomeIcons.eraser,
                          size: 20,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setOption(
                              targetNotifier: showEraserSlider,
                              value: !showEraserSlider.value);
                          sketchProvider.toggleEraser(showEraserSlider.value);
                        },
                      ),

                      ///clear canvas
                      IconButton(
                        icon: const Icon(
                          FontAwesomeIcons.trashCan,
                          size: 20,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          sketchProvider.clearCanvas();
                          undoRedo.clear();
                          setOption(setAllTo: false);
                        },
                      ),

                      ///undo
                      IconButton(
                        icon: const Icon(
                          FontAwesomeIcons.rotateLeft,
                          size: 20,
                          color: Colors.black,
                        ),
                        onPressed: sketchProvider.sketches.isNotEmpty
                            ? () {
                                undoRedo.undo();
                              }
                            : null,
                      ),

                      ///redo
                      ValueListenableBuilder(
                          valueListenable: undoRedo.canRedo,
                          builder: (context, canRedo, _) {
                            return IconButton(
                              icon: const Icon(
                                FontAwesomeIcons.rotateRight,
                                size: 20,
                                color: Colors.black,
                              ),
                              onPressed: canRedo
                                  ? () {
                                      undoRedo.redo();
                                    }
                                  : null,
                            );
                          }),

                      ///change background image n color
                      IconButton(
                        icon: const Icon(
                          FontAwesomeIcons.laptopMedical,
                          size: 20,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setOption(
                              targetNotifier: showBackgroundOption,
                              value: !showBackgroundOption.value);
                        },
                      ),
                      //reset background
                      IconButton(
                        icon: const Icon(Icons.hide_image_outlined),
                        onPressed: () {
                          sketchProvider.clearCachedImage();
                        },
                      ),

                      ///browser
                      IconButton(
                        icon: const Icon(
                          FontAwesomeIcons.globe,
                          size: 20,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          // drawingState.clearCanvas();
                        },
                      ),

                      ///barcode
                      IconButton(
                        icon: const Icon(
                          Icons.qr_code_scanner,
                          size: 20,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            // showLoginOptions = !showLoginOptions;
                          });
                          // drawingState.clearCanvas();
                        },
                      ),

                      ///
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ///save, number and stack
                          IconButton(
                            icon: const Icon(
                              FontAwesomeIcons.plus,
                              size: 20,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              // drawingState.clearCanvas();
                            },
                          ),

                          /// number of things save
                          const Text('1/10'),

                          ///stack icons
                          IconButton(
                            icon: const Icon(
                              FontAwesomeIcons.stackOverflow,
                              size: 20,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              sideBackgroundImageList.value =
                                  !sideBackgroundImageList.value;
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),

              ///background setting ui
              ValueListenableBuilder(
                  valueListenable: showBackgroundOption,
                  builder: (context, showBackground, _) {
                    return showBackground
                        ? const BackGroundDesignOptions()
                        : const SizedBox.shrink();
                  }),

              // Pencil Settings UI
              ValueListenableBuilder(
                  valueListenable: showPencilOptions,
                  builder: (context, showPencil, _) {
                    return showPencil
                        ? const PencilToolOptions()
                        : const SizedBox.shrink();
                  }),

              ///side image menu
              ValueListenableBuilder(
                  valueListenable: sideBackgroundImageList,
                  builder: (context, sideBackgroundImage, _) {
                    return sideBackgroundImage
                        ? Positioned(
                            right: 0,
                            top: 80,
                            bottom: 50,
                            child: SizedBox(
                              width: 150,
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ///1st row
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          sketchProvider
                                              .loadImage('assets/BG.png');
                                        });
                                      },
                                      child: SizedBox(
                                        height: 80,
                                        width: 150,
                                        child: Image.asset(
                                          'assets/BG.png',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    //BG2
                                    GestureDetector(
                                      onTap: () {
                                        sketchProvider
                                            .loadImage('assets/BG1.jpg');
                                      },
                                      child: SizedBox(
                                        height: 80,
                                        width: 150,
                                        child: Image.asset(
                                          'assets/BG1.jpg',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    //BG3
                                    GestureDetector(
                                      onTap: () {
                                        sketchProvider
                                            .loadImage('assets/BG2.jpg');
                                      },
                                      child: SizedBox(
                                        height: 80,
                                        width: 150,
                                        child: Image.asset(
                                          'assets/BG2.jpg',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),

                                    ///second roll
                                    GestureDetector(
                                      onTap: () {
                                        sketchProvider
                                            .loadImage('assets/BG3.png');
                                      },
                                      child: SizedBox(
                                        height: 80,
                                        width: 150,
                                        child: Image.asset(
                                          'assets/BG3.png',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    //BG5
                                    GestureDetector(
                                      onTap: () {
                                        sketchProvider
                                            .loadImage('assets/BG4.png');
                                      },
                                      child: SizedBox(
                                        height: 80,
                                        width: 150,
                                        child: Image.asset(
                                          'assets/BG4.png',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    //BG6
                                    GestureDetector(
                                      onTap: () {
                                        sketchProvider
                                            .loadImage('assets/BG5.jpg');
                                      },
                                      child: SizedBox(
                                        height: 80,
                                        width: 150,
                                        child: Image.asset(
                                          'assets/BG5.jpg',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),

                                    ///3rd roll
                                    GestureDetector(
                                      onTap: () {
                                        sketchProvider
                                            .loadImage('assets/BG3.png');
                                      },
                                      child: SizedBox(
                                        height: 80,
                                        width: 150,
                                        child: Image.asset(
                                          'assets/BG3.png',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    //BG5
                                    GestureDetector(
                                      onTap: () {
                                        sketchProvider
                                            .loadImage('assets/BG4.png');
                                      },
                                      child: SizedBox(
                                        height: 80,
                                        width: 150,
                                        child: Image.asset(
                                          'assets/BG4.png',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    //BG6
                                    GestureDetector(
                                      onTap: () {
                                        sketchProvider
                                            .loadImage('assets/BG6.jpg');
                                      },
                                      child: SizedBox(
                                        height: 80,
                                        width: 150,
                                        child: Image.asset(
                                          'assets/BG6.jpg',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : const SizedBox.shrink();
                  }),

              ///eraser slider
              ValueListenableBuilder(
                  valueListenable: showEraserSlider,
                  builder: (context, showEraser, _) {
                    return showEraser
                        ? Positioned(
                            left: 500,
                            bottom: 50,
                            child: SizedBox(
                              width: 300,
                              child:
                                  //the slider for stroke width thickness
                                  Slider(
                                min: 3.0,
                                max: 50.0,
                                value: sketchProvider.strokeWidth,
                                onChanged: (value) {
                                  sketchProvider.updateStrokeWidth(value);
                                },
                              ),
                            ),
                          )
                        : const SizedBox.shrink();
                  }),
            ],
          );
        },
      ),
    );
  }
}

class _UndoRedoStack {
  final AllSketchesNotifier provider;
  _UndoRedoStack(this.provider) {
    _sketchCount = provider.sketches.length;
    provider.addListener(_sketchesCountListener);
  }

  ///Whether redo operation is possible.
  ValueNotifier<bool> get canRedo => _canRedo;
  late final ValueNotifier<bool> _canRedo = ValueNotifier(false);

  late final List<Sketch> _redoStack = [];

  late int _sketchCount;

  void _sketchesCountListener() {
    print('reod stackkkk length is ${_redoStack.length}');
    if (provider.sketches.length > _sketchCount) {
      print('clearing the redo stack');
      _redoStack.clear();
      _canRedo.value = false;
      _sketchCount = provider.sketches.length;
    }
  }

  void clear() {
    _sketchCount = 0;
    _canRedo.value = false;
  }

  void undo() {
    final sketches = List<Sketch>.from(provider.sketches);
    if (sketches.isNotEmpty) {
      _sketchCount--;
      _redoStack.add(sketches.removeLast());
      print('redo stack length is ${_redoStack.length}');
      provider.sketches = sketches;
      _canRedo.value = true;
      provider.sketch = null;
    }
    print('redo stack length again is ${_redoStack.length}');
  }

  void redo() {
    print('redo is empty ${_redoStack.isEmpty}');
    if (_redoStack.isEmpty) return;
    final sketch = _redoStack.removeLast();
    _canRedo.value = _redoStack.isNotEmpty;
    _sketchCount++;
    provider.sketches = [...provider.sketches, sketch];
  }

  void dispose() {
    provider.removeListener(_sketchesCountListener);
  }
}
