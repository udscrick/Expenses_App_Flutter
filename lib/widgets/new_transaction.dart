import 'package:flutter/material.dart';
import 'package:my_expenses_app/models/transaction.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final newTransactionHandler;
  NewTransaction(this.newTransactionHandler);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();
  DateTime selectedDate;

  void _submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    final txnDate = selectedDate;
    if (enteredTitle.isEmpty || enteredAmount <= 0 || txnDate == null) {
      return; //Stops function execution if this criteria is met
    }
    var txn = Transaction(
        amount: enteredAmount,
        title: enteredTitle,
        date: txnDate,
        id: 3.toString());
    widget.newTransactionHandler(
        txn); //AUtomatically gets added when we refactor to stateful widgets
    Navigator.of(context).pop();
  }

  void _presentDatePicker(){
    
       showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2020), lastDate: DateTime.now())
    .then((pickedDate){

      if(pickedDate==null){
        return;
      }
      else{
        setState(() {
            selectedDate = pickedDate;
        });
        
        }
    });//WIll be triggered once the user picks a date
   
   
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Card(
        child: Container(
          padding: EdgeInsets.only(
            top:10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom+10//Allow space for the keyboard so that the keyboard does not hide the text fields
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleController,
                // onChanged: (value)=>{
                //   titleInput = value
                // },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) =>
                    _submitData(), //Called when the submit button is pressed on phone's keyboard.
                // onChanged: (value)=>{amountInput = value},
              ),
              Container(
                height: 60,
                child: Row(
                  children: [
                    Expanded(child: Text(selectedDate==null?'No date chosen':DateFormat.yMd().format(selectedDate))),
                    FlatButton(
                      child: Text('Choose a date',style: TextStyle(fontWeight: FontWeight.bold),),
                      textColor: Theme.of(context).primaryColor,
                      onPressed: _presentDatePicker,
                    )
                  ],
                ),
              ),
              RaisedButton(
                child: Text('Add Transaction'),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: _submitData,
              )
            ],
          ),
        ),
      ),
    );
  }
}
