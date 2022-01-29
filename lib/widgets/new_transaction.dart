import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../model/transaction.dart';

//it is a stateless widget because here we also dont want to change the ui we just want to store the data of our transactions

class NewTransaction extends StatefulWidget {
  final Function addsTxn;

  //creating a function of adding transaction
  NewTransaction(this.addsTxn);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  //making a variable to store our picked date
  DateTime _userPickedDate;

  void _addData() {
    //making sure that the user doesnt enter the transaction without any data in it
    final _enteredTitle = _titleController.text;
    final _enteredAmount = double.parse(_amountController.text);
    final _userPickedDateTwo =
        _userPickedDate; //we have to create another variable to store the value of userPickedDate because the variable created outside the _addData function is not working so here we are just storing the value of outer variable insie

    if (_enteredAmount <= 0 ||
        _enteredTitle.isEmpty ||
        _userPickedDate == null) {
      Fluttertoast.showToast(
          msg: 'Kindly enter valid values in the Text and Amount Field',
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT);
      return;
    } else {
      //here we need to pass the _addtransaction function inorder to add the transaction in our list
      widget.addsTxn(_enteredTitle, _enteredAmount, _userPickedDateTwo);

      Navigator.of(context).pop();
    }
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _userPickedDate = pickedDate;
      });
    });
  }

  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'TITLE'),
                controller: _titleController,
                /*onChanged: (val){
                        titleInput = val;
                      },*/
              ),
              TextField(
                decoration: InputDecoration(labelText: 'AMOUNT'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _addData(),
                /*onChanged: (val){
                        amountInput =val;
                      },*/
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Text(_userPickedDate == null
                        ? 'No Date chosen?'
                        : DateFormat.yMMMd().format(_userPickedDate)),
                    SizedBox(
                      width: 10,
                    ),
                    TextButton(
                      onPressed: _presentDatePicker,
                      child: Text(
                        'Choose Date',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: _addData,
                child: Text(
                  'Add Transaction',
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Theme.of(context).primaryColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
