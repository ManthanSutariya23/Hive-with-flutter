import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/constant/const.dart';
import 'package:flutter_application_1/src/screen/home/home.dart';
import 'package:flutter_application_1/src/utils/boxs.dart';
import 'package:flutter_application_1/src/utils/transection.dart';
import 'package:hive_flutter/adapters.dart';


Future<void> main() async {

  await Hive.initFlutter();
  Hive.registerAdapter(TransectionAdapter());
  Boxes.box = await Hive.openBox(boxName);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home()
    );
  }
}
