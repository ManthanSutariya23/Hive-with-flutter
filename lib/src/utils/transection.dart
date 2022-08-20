import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'transection.g.dart';

@HiveType(typeId: 0)
class Transection extends HiveObject {

  @HiveField(0)
  late int amount;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late String date;

  @HiveField(3)
  late bool isExpense;
}

