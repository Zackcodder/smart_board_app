import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smart_board_app/provider/new_provider.dart';
import 'package:smart_board_app/provider/new_sketech_provider.dart';
import 'package:smart_board_app/provider/sketch_provider.dart';
import 'package:smart_board_app/widget/backgound_feature.dart';
import 'package:smart_board_app/widget/pencil_feature.dart';
import 'package:smart_board_app/widget/testing_canvas.dart';

bool showPencilOptions = false;
bool showBackgroundOption = false;
bool sideBackgroundImageList = false;
bool showLoginOptions = false;
bool showEraserSkider = false;

class NewHome extends StatefulWidget {
  const NewHome({super.key});

  @override
  State<NewHome> createState() => _NewHomeState();
}

class _NewHomeState extends State<NewHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AllSketchesNotifier>(
        builder: (context, sketchProvider, _) {
          // final sketchProvider = Provider.of<SketchProvider>(context);
          final newSketchProvider = context.watch<AllSketchesNotifier>();

          return Stack(
            children: [
              Container(
              width: double.maxFinite,
              height: double.maxFinite,
                child: NewDrawingCanvas(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - kToolbarHeight,
                  // canvasGlobalKey: sketchProvider.canvasGlobalKey,
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
                          setState(() {
                            showEraserSkider = false;
                            showBackgroundOption = false;
                            sideBackgroundImageList = false;
                            showPencilOptions = !showPencilOptions;
                            sketchProvider.isEraserActive = false;
                            // sketchProvider.strokeWidth = 3.0;
                          });
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
                          showEraserSkider = !showEraserSkider;
                          newSketchProvider.toggleEraser();
                          // sketchProvider.toggleEraser();
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
                          setState(() {});
                          showEraserSkider = false;
                          context.read<AllSketchesNotifier>().clearCanvas();
                          // context.read<SketchProvider>().clearCanvas();
                        },
                      ),

                      ///undo
                      IconButton(
                        icon: const Icon(
                          FontAwesomeIcons.rotateLeft,
                          size: 20,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            sketchProvider.undo();
                          });
                        },
                      ),

                      ///redo
                      IconButton(
                        icon: const Icon(
                          FontAwesomeIcons.rotateRight,
                          size: 20,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          context.read<SketchProvider>().redo();
                        },
                      ),

                      ///change background image n color
                      IconButton(
                        icon: const Icon(
                          FontAwesomeIcons.laptopMedical,
                          size: 20,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            showEraserSkider = false;
                            showPencilOptions = false;
                            sideBackgroundImageList = !sideBackgroundImageList;
                            showBackgroundOption = !showBackgroundOption;
                          });
                        },
                      ),
                      //reset background
                      IconButton(
                        icon: const Icon(Icons.hide_image_outlined),
                        onPressed: () {
                          showEraserSkider = false;
                          sketchProvider.clearCachedImage();
                          // setBackgroundColor(Colors.white);
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
                              setState(() {
                                sideBackgroundImageList =
                                    !sideBackgroundImageList;
                              });
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),

              ///background setting ui
              Consumer<SketchProvider>(builder: (context, sketchProvider, child) {
                return showBackgroundOption
                    ? const BackGroundDesignOptions()
                    : const SizedBox.shrink();
              }),
              // Pencil Settings UI
              Consumer<SketchProvider>(builder: (context, sketchProvider, child) {
                return showPencilOptions
                    ? const PencilToolOptions()
                    : const SizedBox.shrink();
              }),

              ///side image menu
              Consumer<SketchProvider>(builder: (context, sketchProvider, child) {
                return sideBackgroundImageList
                    ? Positioned(
                        right: 0,
                        top: 80,
                        bottom: 50,
                        child: SizedBox(
                          width: 150,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ///1st row
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      sketchProvider.loadImage('assets/BG.png');
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
                                    sketchProvider.loadImage('assets/BG1.jpg');
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
                                    sketchProvider.loadImage('assets/BG2.jpg');
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
                                    sketchProvider.loadImage('assets/BG3.png');
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
                                    sketchProvider.loadImage('assets/BG4.png');
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
                                    sketchProvider.loadImage('assets/BG5.jpg');
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
                                    sketchProvider.loadImage('assets/BG3.png');
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
                                    sketchProvider.loadImage('assets/BG4.png');
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
                                    sketchProvider.loadImage('assets/BG6.jpg');
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
              Consumer<SketchProvider>(
                builder: (context, provider, child) {
                  return showEraserSkider
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
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
