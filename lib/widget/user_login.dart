import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smart_board_app/provider/sketch_provider.dart';
import 'package:smart_board_app/screens/home.dart';

class UserLoginTag extends StatefulWidget {
  const UserLoginTag({
    super.key,
  });

  @override
  State<UserLoginTag> createState() => _UserLoginTagState();
}

class _UserLoginTagState extends State<UserLoginTag> {
  @override
  Widget build(BuildContext context) {
    final sketchProvider = context.watch<SketchProvider>();
    return Positioned(
        top: 10,
        right: 10,
        child: Container(
          width: 150,
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(30)),
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
        ));
  }
}
