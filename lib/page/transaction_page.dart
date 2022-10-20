import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project_h/boxes.dart';
import 'package:project_h/model/transaction.dart';
import 'package:project_h/widget/transaction_dialog.dart';
import 'package:intl/intl.dart';

class TransactionPage extends StatefulWidget {
  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.pink,
      title: Text('Rezervasyon'),
      centerTitle: true,
    ),
    body: ValueListenableBuilder<Box<Transaction>>(
      valueListenable: Boxes.getTransactions().listenable(),
      builder: (context, box, _) {
        final transactions = box.values.toList().cast<Transaction>();

        return buildContent(transactions);
      },
    ),
    floatingActionButton: FloatingActionButton(
      backgroundColor: Colors.pink,
      child: Icon(Icons.add),
      onPressed: () => showDialog(
        context: context,
        builder: (context) => TransactionDialog(
          onClickedDone: addTransaction,
        ),
      ),
    ),
  );

  Widget buildContent(List<Transaction> transactions) {
    if (transactions.isEmpty) {
      return Center(
        child: Text(
          'Henüz rezervasyonunuz yok!',
          style: TextStyle(fontSize: 24),
        ),
      );
    } else {
      final netExpense = transactions.fold<double>(
        0,
            (previousValue, transaction) => transaction.isExpense
            ? previousValue - transaction.amount
            : previousValue + transaction.amount,
      );
      final newExpenseString = '\$${netExpense.toStringAsFixed(2)}';
      final color = netExpense > 0 ? Colors.green : Colors.red;

      return Column(
        children: [
          SizedBox(height: 24),
          Text(
            'Ödenecek Tutar: $newExpenseString',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: color,
            ),
          ),
          SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: transactions.length,
              itemBuilder: (BuildContext context, int index) {
                final transaction = transactions[index];

                return buildTransaction(context, transaction);
              },
            ),
          ),
        ],
      );
    }
  }

  Widget buildTransaction(
      BuildContext context,
      Transaction transaction,
      ) {
    final color = transaction.isExpense ? Colors.red : Colors.green;
    final date = DateFormat.yMMMd().format(transaction.createdDate);
    final amount = '\$' + transaction.amount.toStringAsFixed(2);
    final room =  transaction.room.toString();
    return Card(
      color: Colors.white,
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        title: Text(
          transaction.name + "-" + transaction.otelname,
          maxLines: 2,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(date +"-"+room+" "+"ODA"),
        trailing: Text(
          amount,
          style: TextStyle(
              color: color, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        children: [
          buildButtons(context, transaction),
        ],
      ),
    );
  }

  Widget buildButtons(BuildContext context, Transaction transaction) => Row(
    children: [
      Expanded(
        child: TextButton.icon(
          label: Text('Edit'),
          icon: Icon(Icons.edit),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TransactionDialog(
                transaction: transaction,
                onClickedDone: (name, amount, isExpense , otelname ,room) =>
                    editTransaction(transaction, name, amount, isExpense , otelname,room),
              ),
            ),
          ),
        ),
      ),
      Expanded(
        child: TextButton.icon(
          label: Text('Delete'),
          icon: Icon(Icons.delete),
          onPressed: () => deleteTransaction(transaction),
        ),
      )
    ],
  );

  Future addTransaction(String name, double amount, bool isExpense,String otelname,int room) async {
    final transaction = Transaction()
      ..name = name
      ..createdDate = DateTime.now()
      ..amount = amount*room
      ..isExpense = isExpense
      ..otelname = otelname
      ..room= room;

    final box = Boxes.getTransactions();
    box.add(transaction);



  }

  void editTransaction(
      Transaction transaction,
      String name,
      double amount,
      bool isExpense,
      String otelname,
      int room,
      ) {
    transaction.name = name;
    transaction.amount = amount;
    transaction.isExpense = isExpense;
    transaction.otelname=otelname;
    transaction.room=room;



    transaction.save();
  }

  void deleteTransaction(Transaction transaction) {

    transaction.delete();

  }
}