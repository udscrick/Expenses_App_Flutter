import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;
  TransactionList(this.transactions, this.deleteTransaction);
  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: [
                  Text(
                    'No Transactions added yet!',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 30,
                  ), //In this case we use it only for spacing purposes
                  Container(
                      child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                    height: constraints.maxHeight * 0.6,
                  ))
                ],
              );
            },
          )
        : ListView.builder(
            itemBuilder: (bldcontext, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                            child: Text('\$${transactions[index].amount}'))),
                  ),
                  trailing: MediaQuery.of(context).size.width > 460 //Show different buttons for different screen widths
                      ? FlatButton.icon(
                          onPressed: () =>
                              deleteTransaction(transactions[index].id),
                          icon: Icon(Icons.delete),
                          textColor: Theme.of(context).errorColor ,
                          label: Text("Delete Item"))
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () =>
                              deleteTransaction(transactions[index].id)),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle:
                      Text(DateFormat.yMMMd().format(transactions[index].date)),
                ),
              );
            }, //called for every item to be rendered on the screen
            itemCount:
                transactions.length, //no of items that need to be "built"

            //For only ListView(without builder):
            // children: transactions
            //     .map(
            //         (tx) => //Transforming the list of transactions into a list of widgets(Cards), so that cards are dynamically rendered
            //             Container(
            //               child:
            //               width: double.infinity,
            //             ))
            //     .toList()
          );
  }
}
