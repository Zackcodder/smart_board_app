import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smart_board_app/models/sketch_model.dart';
import 'package:smart_board_app/provider/sketch_provider.dart';
import 'package:smart_board_app/screens/web_browers_screen.dart';
import 'package:smart_board_app/widget/backgound_feature.dart';
import 'package:smart_board_app/widget/pencil_feature.dart';
import 'package:smart_board_app/widget/testing_canvas.dart';

ValueNotifier<bool> showPencilOptions = ValueNotifier(false);
ValueNotifier<bool> showBackgroundOption = ValueNotifier<bool>(false);
ValueNotifier<bool> sideBackgroundImageList = ValueNotifier<bool>(false);
ValueNotifier<bool> showLoginOptions = ValueNotifier<bool>(false);
ValueNotifier<bool> showEraserSlider = ValueNotifier<bool>(false);
ValueNotifier<bool> showBrowserOption = ValueNotifier<bool>(false);

void setOption(
    {ValueNotifier<bool>? targetNotifier, bool? value, bool? setAllTo}) {
  if (setAllTo != null) {
    showPencilOptions.value = setAllTo;
    showBackgroundOption.value = setAllTo;
    sideBackgroundImageList.value = setAllTo;
    showLoginOptions.value = setAllTo;
    showEraserSlider.value = setAllTo;
    showBrowserOption.value = setAllTo;
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
      if (targetNotifier != showBrowserOption) showBrowserOption.value = false;
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
    undoRedo = _UndoRedoStack(context.read<SketchProvider>());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<SketchProvider>(
        builder: (context, sketchProvider, _) {
          return Stack(
            children: [
              ///canvas
              SizedBox(
                width: double.maxFinite,
                height: double.maxFinite,
                child: NewDrawingCanvas(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - kToolbarHeight,
                ),
              ),

              ///login icon
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
                            setOption(
                                targetNotifier: showLoginOptions,
                                value: !showLoginOptions.value);
                            sketchProvider.toggleNewEraser(false);
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

              ///browser options
              ValueListenableBuilder(
                  valueListenable: showBrowserOption,
                  builder: (context, showBrowser, _) {
                    return showBrowser
                        ? Align(
                            alignment: Alignment.center,
                            child: Container(
                              color: const Color.fromARGB(255, 241, 244, 247),
                              height: 300,
                              width: 300,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ///bing browser
                                  GestureDetector(
                                    onTap: () {
                                      showBrowserOption.value = false;
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const WebBrowersScreen(
                                                  url: "https://www.bing.com/"),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(20),
                                      margin: const EdgeInsets.all(10),
                                      color: const Color.fromARGB(
                                          255, 196, 180, 179),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text('Bing Browser'),
                                          Icon(FontAwesomeIcons.globe),
                                        ],
                                      ),
                                    ),
                                  ),

                                  ///longman dictionary
                                  GestureDetector(
                                    onTap: () {
                                      showBrowserOption.value = false;
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const WebBrowersScreen(
                                                  url:
                                                      "https://www.ldoceonline.com/"),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(20),
                                      margin: const EdgeInsets.all(10),
                                      color: const Color.fromARGB(
                                          255, 196, 180, 179),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text('Longman'),
                                          Icon(FontAwesomeIcons.globe),
                                        ],
                                      ),
                                    ),
                                  ),

                                  ///webster
                                  GestureDetector(
                                    onTap: () {
                                      showBrowserOption.value = false;
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const WebBrowersScreen(
                                                  url:
                                                      "https://www.merriam-webster.com/"),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(20),
                                      margin: const EdgeInsets.all(10),
                                      color: const Color.fromARGB(
                                          255, 196, 180, 179),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text('Webster'),
                                          Icon(FontAwesomeIcons.globe),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : const SizedBox.shrink();
                  }),

              //button button options
              Positioned(
                left: 200,
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
                      ///brush
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
                          sketchProvider.toggleNewEraser(false);
                        },
                      ),

                      ///eraser for canvas
                      IconButton(
                        icon: const Icon(
                          FontAwesomeIcons.eraser,
                          size: 20,
                          color: Colors.black,
                        ),
                        onPressed: () async {
                          setOption(
                              targetNotifier: showEraserSlider,
                              value: !showEraserSlider.value);
                          sketchProvider
                              .toggleNewEraser(showEraserSlider.value);
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
                        icon: Icon(
                          FontAwesomeIcons.rotateLeft,
                          size: 20,
                          color: sketchProvider.sketches.isNotEmpty
                              ? Colors.black
                              : Colors.grey,
                        ),
                        onPressed: sketchProvider.sketches.isNotEmpty
                            ? () {
                                sketchProvider.toggleNewEraser(false);
                                undoRedo.undo();
                              }
                            : null,
                      ),

                      ///redo
                      ValueListenableBuilder(
                          valueListenable: undoRedo.canRedo,
                          builder: (context, canRedo, _) {
                            return IconButton(
                              icon: Icon(
                                FontAwesomeIcons.rotateRight,
                                size: 20,
                                color: canRedo ? Colors.black : Colors.grey,
                              ),
                              onPressed: canRedo
                                  ? () {
                                      sketchProvider.toggleNewEraser(false);
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
                          sideBackgroundImageList.value = true;
                          sketchProvider.toggleNewEraser(false);
                        },
                      ),

                      //reset background
                      IconButton(
                        icon: const Icon(Icons.hide_image_outlined),
                        onPressed: () {
                          context
                              .read<SketchProvider>()
                              .clearCachedImage(sketchProvider.backgroundColor);
                          sketchProvider.toggleNewEraser(false);
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
                          setOption(
                              targetNotifier: showBrowserOption,
                              value: !showBrowserOption.value);
                          sketchProvider.toggleNewEraser(false);
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
                              sketchProvider.toggleNewEraser(false);
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
                    final sketchProvider = context.watch<SketchProvider>();
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
                                        sketchProvider
                                            .loadImage('assets/BG.png');
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

              ///login screen
              ValueListenableBuilder(
                  valueListenable: showLoginOptions,
                  builder: (context, loginOption, child) {
                    return loginOption
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
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              showLoginOptions.value = false;
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.all(10),
                                              padding: const EdgeInsets.all(10),
                                              height: 40,
                                              width: 150,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.red,
                                              ),
                                              child: const Center(
                                                  child: Text('SignOut')),
                                            ),
                                          ),
                                        ),

                                        ///login
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              showLoginOptions.value = false;
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.all(10),
                                              padding: const EdgeInsets.all(10),
                                              height: 40,
                                              width: 150,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.green,
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  'Login',
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
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
            ],
          );
        },
      ),
    );
  }
}

class _UndoRedoStack {
  final SketchProvider provider;
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
    if (provider.sketches.length > _sketchCount) {
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
      provider.sketches = sketches;
      _canRedo.value = true;
      provider.sketch = null;
    }
  }

  void redo() {
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
