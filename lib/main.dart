import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_board_app/models/storage_provider.dart';
import 'package:smart_board_app/provider/new_provider.dart';
import 'package:smart_board_app/provider/new_sketech_provider.dart';
import 'package:smart_board_app/provider/sketch_provider.dart';
import 'package:smart_board_app/screens/newHome.dart';
import 'package:smart_board_app/service/sketch_service.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
    ChangeNotifierProvider(
      create: (context) => SketchProvider()),
        ChangeNotifierProvider(create: (_) => AllSketchesNotifier()),
        ChangeNotifierProvider(create: (_) => NewSketchProvider()),
        ChangeNotifierProvider(create: (_) => StorageProvider()),
        ChangeNotifierProvider(
          create: (context) => SketchDataService(storageProvider: StorageProvider()),
        ),

      ],
      child: MaterialApp(
        title: 'SmartBoard',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:  const NewHome(),
        // const SketchView(),
      ),
    );
  }
}
