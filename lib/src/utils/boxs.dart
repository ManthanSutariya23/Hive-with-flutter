
import 'package:flutter_application_1/src/constant/const.dart';
import 'package:flutter_application_1/src/utils/transection.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box? box;
  static Box<Transection> getTransections() => Hive.box<Transection>(boxName);
}
