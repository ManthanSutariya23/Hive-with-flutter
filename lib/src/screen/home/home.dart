import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/constant/const.dart';
import 'package:flutter_application_1/src/model/model.dart';
import 'package:flutter_application_1/src/screen/dialog/dialog.dart';
import 'package:flutter_application_1/src/utils/boxs.dart';
import 'package:flutter_application_1/src/utils/transection.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';


class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final List<Transection> transection = [];

  var mapData;
  List<Transection> listData = [];

  Timer? t;
  bool load = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  getdata() async {
    setState(() {
      load = true;
    });
    mapData = null;
    mapData = Boxes.box!.toMap();
    listData = [];
    await mapData.forEach((k,v) {
      listData.add(v);
    });
    t = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if(mapData != null) {
          load = false;
        }
        timer.cancel();
        t!.cancel();
      });
    });
  }

  @override
  void dispose() {
    Hive.box(boxName).close();
    t!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => TransactionDialog(),
          ).then((value){
            getdata();
          });
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: 
        load
        ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 20,),
              Text('Loading...')
            ],
          )
        )
        : buildContent(listData),
      ),
    );
  }

  Widget buildContent(List<Transection> transactions) {
    if (transactions.isEmpty) {
      return Center(
        child: Text(
          'No expenses yet!',
          style: TextStyle(fontSize: 24),
        ),
      );
    } else {
      final netExpense = transactions.fold<double>(
        0,
        (previousValue, transaction) => transaction.isExpense
            ? previousValue - transaction.amount
            : previousValue + transaction.amount,
      );
      final newExpenseString = '\$${netExpense.toStringAsFixed(2)}';
      final color = netExpense > 0 ? Colors.green : Colors.red;

      return Column(
        children: [
          SizedBox(height: 24),
          Text(
            'Net Expense: $newExpenseString',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: color,
            ),
          ),
          SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: transactions.length,
              itemBuilder: (BuildContext context, int index) {
                final transaction = transactions[index];

                return buildTransaction(context, transaction);
              },
            ),
          ),
        ],
      );
    }
  }

  Widget buildTransaction(
    BuildContext context,
    Transection transaction,
  ) {
    final color = transaction.isExpense ? Colors.red : Colors.green;
    final amount = '\$' + transaction.amount.toStringAsFixed(2);

    return InkWell(
      onLongPress: () {
        // delete
        transaction.delete();
        getdata();
      },
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => TransactionDialog(transaction: transaction),
        ).then((value){
            getdata();
          });
      },
      child: Card(
        color: Colors.white,
        child: ListTile(
          title: Text(
            transaction.name,
            maxLines: 2,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          subtitle: Text(transaction.date),
          trailing: Text(
            amount,
            style: TextStyle(
                color: color, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
    );
  }
}


