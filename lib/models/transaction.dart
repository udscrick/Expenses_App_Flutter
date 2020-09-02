//Creating a blueprint for each transaction

import 'package:flutter/foundation.dart';

class Transaction {
  String id;
  String title; //To store purchase title
  double amount; //Amount spent on a commodity
  DateTime date; //Date of transaction

  Transaction({@required this.id, @required this.title,@required this.amount,@required this.date});
}
