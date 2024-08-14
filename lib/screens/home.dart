import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smart_board_app/provider/sketch_provider.dart';
import 'package:smart_board_app/widget/backgound_feature.dart';
import 'package:smart_board_app/widget/drawing%20_canvas_widget.dart';
import 'package:smart_board_app/widget/pencil_feature.dart';

bool showPencilOptions = false;
bool showBackgroundOption = false;
bool sideBackgroundImageList = false;
bool showLoginOptions = false;
bool showEraserSkider = false;

class SketchView extends StatefulWidget {
  const SketchView({super.key});

  @override
  State<SketchView> createState() => _SketchViewState();
}

class _SketchViewState extends State<SketchView>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    final sketchProvider = context.watch<SketchProvider>();

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            ///drawing canvas
            Container(
              color: Colors.white,
              width: double.maxFinite,
              height: double.maxFinite,
              child: DrawingCanvas(),
            ),
            Positioned(
                top: 10,
                right: 10,
                child: Container(
                  width: 150,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(30)),
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        'Tony',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      GestureDetector(
                        onTap: () {
                          // sketchProvider.toggleLoginOption();
                          setState(() {
                            showLoginOptions = !showLoginOptions;
                          });
                        },
                        child: const CircleAvatar(
                          radius: 30,
                          child: Icon(
                            FontAwesomeIcons.user,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),

            ///bottom icons
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
                        sketchProvider.toggleEraser();
                        // context.read<SketchProvider>().erase(currentTouchPoint, eraserSize);
                        // context.read<SketchProvider>().toggleEraser();
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
                        context.read<SketchProvider>().clearCanvas();
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
                          // context.read<SketchProvider>().undo();
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
                          showLoginOptions = !showLoginOptions;
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

            // Pencil Settings UI
            Consumer<SketchProvider>(builder: (context, provider, child) {
              return showPencilOptions
                  ? PencilToolOptions()
                  : const SizedBox.shrink();
            }),

            ///background setting ui
            Consumer<SketchProvider>(builder: (context, provider, child) {
              return showBackgroundOption
                  ? const BackGroundDesignOptions()
                  : const SizedBox.shrink();
            }),

            ///side image menu
            Consumer<SketchProvider>(builder: (context, provider, child) {
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

            ///login UI
            Consumer<SketchProvider>(builder: (context, provider, child) {
              return showLoginOptions
                  ? Positioned(
                      top: 100,
                      bottom: 100,
                      right: 50,
                      left: 50,
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        width: double.maxFinite,
                        height: 400,
                        child: ListView(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.grey)),
                              height: 100,
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundColor: Colors.grey,
                                    child: Icon(FontAwesomeIcons.user),
                                  ),
                                  Text(
                                    "姓名",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  IconButton(
                                      onPressed: null,
                                      icon: Icon(
                                        Icons.edit_document,
                                        size: 40,
                                        color: Colors.grey,
                                      ))
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.grey)),
                              height: 100,
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundColor: Colors.grey,
                                    child: Icon(FontAwesomeIcons.user),
                                  ),
                                  Text(
                                    '托尼',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  IconButton(
                                      onPressed: null,
                                      icon: Icon(
                                        Icons.edit_document,
                                        size: 40,
                                        color: Colors.grey,
                                      ))
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.grey)),
                              height: 100,
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundColor: Colors.grey,
                                    child: Icon(FontAwesomeIcons.user),
                                  ),
                                  Text(
                                    'name',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  IconButton(
                                      onPressed: null,
                                      icon: Icon(
                                        Icons.edit_document,
                                        size: 40,
                                        color: Colors.grey,
                                      ))
                                ],
                              ),
                            ),

                            ///button
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ///sign out
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        showLoginOptions = !showLoginOptions;
                                      });
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.all(10),
                                      padding: const EdgeInsets.all(10),
                                      height: 40,
                                      width: 300,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.red,
                                      ),
                                      child:
                                          const Center(child: Text('SignOut')),
                                    ),
                                  ),

                                  ///login
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        showLoginOptions = !showLoginOptions;
                                      });
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.all(10),
                                      padding: const EdgeInsets.all(10),
                                      height: 40,
                                      width: 300,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.green,
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Login',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox.shrink();
            }),

            ///eraser slider
            Consumer<SketchProvider>(builder: (context, provider, child) {
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
            }),
          ],
        ),
      ),
    );
  }
}
