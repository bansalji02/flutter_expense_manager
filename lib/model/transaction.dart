import 'package:flutter/foundation.dart';

//it is not a widget , but it is a simple class basically a data model or our custom data to  store the objects or data of our requirement

class Transaction {
  final String id;
  final String title;
  final double value;
  final DateTime date;

  Transaction(@required this.id, @required this.title, @required this.value,
      @required this.date);
}
