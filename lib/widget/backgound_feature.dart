import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:smart_board_app/provider/sketch_provider.dart';

class BackGroundDesignOptions extends StatelessWidget {
  const BackGroundDesignOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final sketchProvider = context.watch<SketchProvider>();
    return Positioned(
      bottom: 50,
      right: 160,
      left: 20,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 5,
            ),
          ],
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///category selection
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///adult
                  Container(
                    margin: const EdgeInsets.only(bottom: 25),
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.red),
                    ),
                    child: const Text(
                      'Adult Class',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),

                  ///middle age
                  Container(
                    margin: const EdgeInsets.only(bottom: 25),
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.red),
                    ),
                    child: const Center(
                      child: Text('Teen Class'),
                    ),
                  ),

                  ///children
                  Container(
                    margin: const EdgeInsets.only(bottom: 25),
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.red),
                    ),
                    child: const Center(
                      child: Text('children Class'),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20,),

              ///templete display
              SizedBox(
                height: 200,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///1st row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ///BG1
                          GestureDetector(
                            onTap: () {
                                sketchProvider
                                    .setBackgroundImage('assets/BG.png');
                             
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
                            width: 20,
                          ),
                          //BG2
                          GestureDetector(
                            onTap: () {
                              sketchProvider.setBackgroundImage('assets/BG1.jpg');
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
                            width: 20,
                          ),
                          //BG3
                          GestureDetector(
                            onTap: () {
                              sketchProvider.setBackgroundImage('assets/BG2.jpg');
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
                        ],
                      ),
                
                      const SizedBox(height: 20,),
                      ///second roll
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ///BG4
                          GestureDetector(
                            onTap: () {
                              sketchProvider.setBackgroundImage('assets/BG3.png');
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
                            width: 20,
                          ),
                          //BG5
                          GestureDetector(
                            onTap: () {
                              sketchProvider.setBackgroundImage('assets/BG4.png');
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
                            width: 20,
                          ),
                          //BG6
                          GestureDetector(
                            onTap: () {
                              sketchProvider.setBackgroundImage('assets/BG5.jpg');
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
                        ],
                      ),
                
                      const SizedBox(height: 20,),
                      ///3rd roll
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ///BG4
                          GestureDetector(
                            onTap: () {
                              sketchProvider.setBackgroundImage('assets/BG3.png');
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
                            width: 20,
                          ),
                          //BG5
                          GestureDetector(
                            onTap: () {
                              sketchProvider.setBackgroundImage('assets/BG4.png');
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
                            width: 20,
                          ),
                          //BG6
                          GestureDetector(
                            onTap: () {
                              sketchProvider.setBackgroundImage('assets/BG6.jpg');
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
                       const SizedBox(height: 20,),
                      
                      ///4th roll
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ///BG4
                          GestureDetector(
                            onTap: () {
                              sketchProvider.setBackgroundImage('assets/BG3.png');
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
                            width: 20,
                          ),
                          //BG5
                          GestureDetector(
                            onTap: () {
                              sketchProvider.setBackgroundImage('assets/BG4.png');
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
                            width: 20,
                          ),
                          //BG6
                          GestureDetector(
                            onTap: () {
                              sketchProvider.setBackgroundImage('assets/BG5.jpg');
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
                        ],
                      ),
                
                    ],
                  ),
                ),
              ),

              ///background color option
              Column(
                children: [
                  ///1st roll
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ///grey color
                      GestureDetector(
                        onTap: () {
                          sketchProvider.setBackgroundColor(Colors.grey);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 15, left: 20),
                          color: Colors.grey,
                          height: 50,
                          width: 50,
                        ),
                      ),

                      ///brown
                      GestureDetector(
                        onTap: () {
                          sketchProvider.setBackgroundColor(Colors.brown);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                            right: 15,
                          ),
                          color: Colors.brown,
                          height: 50,
                          width: 50,
                        ),
                      ),

                      ///offwhite
                      GestureDetector(
                        onTap: () {
                          sketchProvider.setBackgroundColor(Colors.red);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                            right: 15,
                          ),
                          color: Colors.red,
                          height: 50,
                          width: 50,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  ///2nd roll
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ///blue color
                      GestureDetector(
                        onTap: () {
                          sketchProvider.setBackgroundColor(Colors.blue);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 15, left: 20),
                          color: Colors.blue,
                          height: 50,
                          width: 50,
                        ),
                      ),

                      ///green
                      GestureDetector(
                        onTap: () {
                          sketchProvider.setBackgroundColor(Colors.green);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                            right: 15,
                          ),
                          color: Colors.green,
                          height: 50,
                          width: 50,
                        ),
                      ),

                      ///yellow
                      GestureDetector(
                        onTap: () {
                          sketchProvider.setBackgroundColor(Colors.yellow);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                            right: 15,
                          ),
                          color: Colors.yellow,
                          height: 50,
                          width: 50,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  ///3rd roll
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ///accent blue color
                      GestureDetector(
                        onTap: () {
                            sketchProvider.setBackgroundColor(Colors.white10);
                         
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 15, left: 20),
                          color: Colors.white10,
                          height: 50,
                          width: 50,
                        ),
                      ),

                      ///blue grey
                      GestureDetector(
                        onTap: () {
                          sketchProvider.setBackgroundColor(Colors.blueGrey);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                            right: 15,
                          ),
                          color: Colors.blueGrey,
                          height: 50,
                          width: 50,
                        ),
                      ),

                      ///greenAccent
                      GestureDetector(
                        onTap: () {
                          sketchProvider.setBackgroundColor(Colors.greenAccent);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                            right: 15,
                          ),
                          color: Colors.greenAccent,
                          height: 50,
                          width: 50,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              ColorPicker(
                colorPickerWidth: 200,
                labelTypes: const [],
                pickerAreaHeightPercent: 0.5,
                enableAlpha: false,
                pickerColor: sketchProvider.backgroundColor,
                onColorChanged: (color) {
                  sketchProvider.setBackgroundColor(color);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
