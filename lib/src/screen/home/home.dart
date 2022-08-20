import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/utils/transection.dart';
import 'package:hive/hive.dart';


class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final List<Transection> transection = [];

  @override
  void dispose() {
    Hive.box('transection').close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Text('manthan')
      ),
    );
  }
}


