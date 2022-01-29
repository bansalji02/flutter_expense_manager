import 'package:flutter/material.dart';
import '../model/transaction.dart';
import 'package:intl/intl.dart';

//same reason as new_transaction widget because here we just want to display the list and the change of ui
//is all managed by user_transactions widget

class TransactionList extends StatelessWidget {
  //value of all the transactions to display them in the transaction list
  final List<Transaction> transactions;
  final Function delTxn;

  TransactionList(this.transactions, this.delTxn);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: [
                  Text(
                    'No Expenses added yet!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.2,
                  ),
                  Container(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      )),
                ],
              );
            },
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text(
                            '₹' + transactions[index].value.toStringAsFixed(1)),
                      ),
                    ),
                    radius: 30,
                  ),
                  title: Text(
                    transactions[index].title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    DateFormat().add_yMMMMd().format(transactions[index].date),
                    style: const TextStyle(
                        color: Color.fromRGBO(95, 90, 90, 1), fontSize: 10),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.purple,
                    ),
                    onPressed: () => delTxn(transactions[index].id),
                  ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}

//the code written under can also be used to design the list inside the listView.builder widget
/*
Card(
child: Row(
children: [
Container(
child: Text(
'₹' + transactions[index].value.toStringAsFixed(1),
style: const TextStyle(
fontWeight: FontWeight.bold,
fontSize: 20,
color: Colors.purple),
),
margin: const EdgeInsets.all(10),
padding: const EdgeInsets.all(5),
decoration: BoxDecoration(
border: Border.all(color: Colors.purple, width: 2),
),
),
Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
transactions[index].title,
style: const TextStyle(
color: Colors.black,
fontSize: 20,
fontWeight: FontWeight.bold,
),
),
Text(
DateFormat().format(transactions[index].date),
style: const TextStyle(
color: Colors.grey, fontSize: 10),
),
],
)
],
),
);
*/
