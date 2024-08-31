import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smart_board_app/models/sketch_data_provider.dart';
import 'package:smart_board_app/models/sketch_model.dart';
import 'package:smart_board_app/provider/sketch_provider.dart';

class ShapeMenu extends StatefulWidget {
  @override
  State<ShapeMenu> createState() => _ShapeMenuState();
}

class _ShapeMenuState extends State<ShapeMenu> {
  @override
  Widget build(BuildContext context) {
    final sketchProvider = context.watch<SketchProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///pencil
        Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey[900]!,
              width: 1.5,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          child: Center(
            child: IconButton(
                onPressed: () {
                  sketchProvider.setSelectedShape(DrawingMode.pencil);
                  setState(() {});
                },
                icon: const Icon(
                  FontAwesomeIcons.pencil,
                  size: 20,
                )),
          ),
        ),
        ///Line
        Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey[900]!,
              width: 1.5,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          child: Center(
            child: IconButton(
                onPressed: () {
                  sketchProvider.setSelectedShape(DrawingMode.line);
                  setState(() {});
                },
                icon: const Icon(
                  FontAwesomeIcons.minus,
                  size: 20,
                )),
          ),
        ),
        ///square
        Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey[900]!,
              width: 1.5,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          child: Center(
            child: IconButton(
                onPressed: () {
                  sketchProvider.setSelectedShape(DrawingMode.square);
                  setState(() {});
                },
                icon: const Icon(
                  FontAwesomeIcons.square,
                  size: 20,
                )),
          ),
        ),
        ///circle
        Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey[900]!,
              width: 1.5,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          child: Center(
            child: IconButton(
                onPressed: () {
                  sketchProvider.setSelectedShape(DrawingMode.circle);
                  setState(() {});
                },
                icon: const Icon(
                  FontAwesomeIcons.circle,
                  size: 20,
                )),
          ),
        ),
        ///polygon
        Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey[900]!,
              width: 1.5,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          child: Center(
            child: IconButton(
                onPressed: () {
                  sketchProvider.setSelectedShape(DrawingMode.polygon);
                  setState(() {});
                },
                icon: const Icon(
                  FontAwesomeIcons.drawPolygon,
                  size: 20,
                )),
          ),
        ),
        
      ],
    );
  }
}
