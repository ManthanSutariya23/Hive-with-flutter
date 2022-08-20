import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/utils/boxs.dart';
import 'package:flutter_application_1/src/utils/transection.dart';

class AllFunction {
  final List<Transection> transections = [];
  static Future addData({
    required String name,
    required int amount,
    required bool isExpense,
  }) async {
    String date = DateTime.now().toString().split(" ")[0];
    String finalDate = date.split('-')[2] + "-" + date.split("-")[1] + "-" + date.split("-")[0];
    final transeciton = Transection()
      ..amount = amount
      ..date = finalDate
      .. isExpense = isExpense
      ..name = name;
      Boxes.box!.add(transeciton);
  }

  static void edit({
    required Transection transection,
    required String name,
    required int amount,
    required bool isExpense,
  }) {
    transection.name = name;
    transection.isExpense = isExpense;
    transection.amount = amount;

    transection.save();
  }

  static void deleteTransaction(Transection transaction) {
    // final box = Boxes.getTransactions();
    // box.delete(transaction.key);

    transaction.delete();
    //setState(() => transactions.remove(transaction));
  }

}
