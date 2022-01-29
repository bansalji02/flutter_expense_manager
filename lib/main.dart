import 'package:expensemanager/widgets/chart.dart';
import 'package:flutter/services.dart';

import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';

import './widgets/transaction_list.dart';
import 'package:flutter/material.dart';

import 'model/transaction.dart';

void main() {
  /*WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);*/
  //The above three lines are used to force the app to portrait mode and restricting it to go to landscape mode

  runApp(MyApp());
}

//we have stateless widget here because in this widget we want to place all the elements of the application with we do no want to change
//like the appbar etc, we do not want to spend our resources rebuilding those elements which already exist as we want them to exist

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'QuickSand',
      ),
      title: 'Expense Manager',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /*String titleInput;
  String amountInput;*/
  final List<Transaction> transactions = [
    /*Transaction('t1', 'food', 230, DateTime.now()),
    Transaction('t2', 'drinks', 550, DateTime.now()),*/
  ];

  bool _switchState = false;

  List<Transaction> get _recentTransactions {
    return transactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime txnDate) {
    final txn =
        Transaction(DateTime.now().toString(), txTitle, txAmount, txnDate);

    setState(() {
      transactions.add(txn);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((element) {
        element.id == id;
      });
    });
  }

  void _startAddingNewTransaction(BuildContext ctx) {
    /*setState(() {

    });*/
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final _isLandScape = mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
      title: const Text(
        'Expense Manager',
      ),
      actions: [
        IconButton(
            onPressed: () => _startAddingNewTransaction(context),
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ))
      ],
    );

    final txnListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionList(transactions, _deleteTransaction),
    );
    //here above i stored the transaction list in a variable so that it is easier to use multiple times

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (_isLandScape)
              Row(
                children: [
                  Text('Show Chart'),
                  Switch(
                      value: _switchState,
                      onChanged: (value) {
                        setState(() {
                          _switchState = value;
                        });
                      }),
                ],
              ),
            if (!_isLandScape)
              Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.3,
                child: Chart(_recentTransactions),
              ),
            if (!_isLandScape) txnListWidget,
            if (_isLandScape)
              _switchState
                  ? Container(
                      height: (mediaQuery.size.height -
                              appBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.7,
                      child: Chart(_recentTransactions),
                    )
                  : txnListWidget
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddingNewTransaction(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
