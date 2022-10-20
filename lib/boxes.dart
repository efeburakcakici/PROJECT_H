import 'package:hive/hive.dart';
import 'package:project_h/model/transaction.dart';

class Boxes {
  static Box<Transaction> getTransactions() =>
      Hive.box<Transaction>('transactions');

}

