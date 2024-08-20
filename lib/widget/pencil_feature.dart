import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smart_board_app/provider/new_provider.dart';
import 'package:smart_board_app/provider/sketch_provider.dart';

///
class PencilToolOptions extends StatelessWidget {
  const PencilToolOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final sketchProvider = context.watch<SketchProvider>();
    final newSketchProvider = context.watch<AllSketchesNotifier>();

    return Positioned(
      bottom: 50,
      left: 10,
      right: 10,
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///stroker ticker and dash feature
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///1st roll for strock thickness and pen for normal line
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          // sketchProvider.toggleDashed();
                        },
                        icon: const Icon(
                          FontAwesomeIcons.penNib,
                          color: Colors.black,
                        )),
                    const SizedBox(
                      width: 25,
                    ),

                    ///first thickness
                    GestureDetector(
                      onTap: () {
                        newSketchProvider.updateStrokeWidth(9);
                       
                      },
                      child: const CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),

                    ///secind thickness
                    GestureDetector(
                      onTap: () {
                        newSketchProvider.updateStrokeWidth(10);
                        
                      },
                      child: const CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),

                    ///3rd thickness
                    GestureDetector(
                      onTap: () {
                          newSketchProvider.updateStrokeWidth(12);
                        
                      },
                      child: const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.black,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20,),

                ///2nd roll for strock thickness and pen for dash line
                Row(
                  children: [
                    const Icon(FontAwesomeIcons.penNib),
                    const SizedBox(
                      width: 25,
                    ),

                    ///first thickness
                    GestureDetector(
                      onTap: () {
                        newSketchProvider.updateStrokeWidth(5);
                      },
                      child: const CircleAvatar(
                        radius: 5,
                        backgroundColor: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      width: 75,
                    ),

                    ///secind thickness
                    GestureDetector(
                      onTap: () {
                        newSketchProvider.updateStrokeWidth(7);
                      },
                      child: const CircleAvatar(
                        radius: 7,
                        backgroundColor: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      width: 75,
                    ),

                    ///3rd thickness
                    GestureDetector(
                      onTap: () {
                        newSketchProvider.updateStrokeWidth(9);
                      },
                      child: const CircleAvatar(
                        radius: 9,
                        backgroundColor: Colors.black,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20,),
                ///stroker thickness slider
                SizedBox(
                  width: 300,
                  child:
                      //the slider for stroke width thickness
                      Slider(
                    min: 3.0,
                    max: 50.0,
                    value: newSketchProvider.strokeWidth,
                    onChanged: (value) {
                      newSketchProvider.updateStrokeWidth(value);
                    },
                  ),
                ),
              ],
            ),

            // Color Picker
            BlockPicker(
              pickerColor: sketchProvider.selectedColor,
              onColorChanged: (color) {
                              newSketchProvider.updateColor(color);
                
              },
            ),
           
            ///color pallette
            ColorPicker(
              colorPickerWidth: 200,
              labelTypes: const [],
              pickerAreaHeightPercent: 0.5,
              enableAlpha: false,
              pickerColor: newSketchProvider.selectedColor,
              onColorChanged: (color) {
                newSketchProvider.updateColor(color);
              },
            ),
          ],
        ),
      ),
    );
  }
}
