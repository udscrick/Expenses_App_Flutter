import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_expenses_app/models/transaction.dart';
import 'package:my_expenses_app/widgets/charts.dart';
import 'package:my_expenses_app/widgets/new_transaction.dart';
import 'package:my_expenses_app/widgets/transaction_list.dart';
import './widgets/transaction_container.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();//Do this before modifying app wide settings otherwise it wont work for some devices
  //     SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Expenses',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amberAccent,
          errorColor: Colors.red,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                    fontFamily: 'OpenSans', fontSize: 20, color: Colors.black),
                button: TextStyle(color: Colors.white)),
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // String titleInput;
  // String amountInput;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _onAddClick(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: NewTransaction(_addNewTransaction),
          );
        });
  }

  final List<Transaction> transactions = [
    // Transaction(
    //     id: '1', title: 'Amazon Sale', amount: 752.00, date: DateTime.now()),
    // Transaction(
    //     id: '2', title: 'Groceries', amount: 8972.50, date: DateTime.now()),
 
  ];

  List<Transaction> get _recentTransactions {
    return transactions
        .where((tx) => tx.date.isAfter(
              DateTime.now().subtract(
                Duration(days: 7),
              ),
            ))
        .toList(); //Works like filter. Only returns those transactions that were made in the last 7 days
  }

  bool _showChart = false;
  void _addNewTransaction(Transaction txn) {
    setState(() {
      txn.id = DateTime.now().toString();
      transactions.add(txn);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    //We are storing appBar here so that we can later access its different properties(such as height) from another class as well
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text("My Expenses"),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _onAddClick(context),
        )
      ],
    );
    final txnListWidget = Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.7,
                child: TransactionList(transactions, _deleteTransaction));
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start, //For a column main axis is from top to bottom and cross axis is from left to right, vice versa for row(options: start,center,end,space around,space between)
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
           if(isLandscape) Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Show Chart"),
                Switch(
                  value: _showChart,
                  onChanged: (val){
                    setState(() {
                      _showChart = val;
                    });
                  },
                )
              ],
            ),
            if(!isLandscape) Container(
                    height: (mediaQuery.size.height -
                            appBar.preferredSize.height -
                            mediaQuery.padding.top) *
                        0.3,
                    child: Charts(transactions)),

                // color: Colors.blue,
            if(!isLandscape)  txnListWidget,
              
            if(isLandscape) _showChart == true?
            Container(
                child: Container(
                    height: (mediaQuery.size.height -
                            appBar.preferredSize.height -
                            mediaQuery.padding.top) *
                        0.7,
                    child: Charts(transactions)),

                // color: Colors.blue,

                width: double.infinity):
            //  TransactionContainer()//We dont need this after adding the bottom sheet as we display only the list here and the transaction details are moved into the bottom sheet
            txnListWidget
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _onAddClick(context),
      ),
    );
  }
}
