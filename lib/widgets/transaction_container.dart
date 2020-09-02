import 'package:flutter/material.dart';
import 'package:my_expenses_app/models/transaction.dart';
import 'package:my_expenses_app/widgets/new_transaction.dart';
import 'package:my_expenses_app/widgets/transaction_list.dart';

class TransactionContainer extends StatefulWidget {
  @override
  _TransactionContainerState createState() => _TransactionContainerState();
}

class _TransactionContainerState extends State<TransactionContainer> {
  
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // NewTransaction(_addNewTransaction),
      // TransactionList(transactions)
    ],);
  }
}