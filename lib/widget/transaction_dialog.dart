import 'package:flutter/material.dart';

import '../model/transaction.dart';

class TransactionDialog extends StatefulWidget {
  final Transaction? transaction;
  final Function(String name, double amount, bool isExpense,String otelname,int room) onClickedDone;

  const TransactionDialog({
    Key? key,
    this.transaction,
    required this.onClickedDone,
  }) : super(key: key);

  @override
  _TransactionDialogState createState() => _TransactionDialogState();
}

class _TransactionDialogState extends State<TransactionDialog> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final otelnameController = TextEditingController();
  final amountController = TextEditingController();
  final roomController = TextEditingController();

  bool isExpense = true;

  @override
  void initState() {
    super.initState();

    if (widget.transaction != null) {
      final transaction = widget.transaction!;
      otelnameController.text= transaction.otelname;
      nameController.text = transaction.name;
      amountController.text = transaction.amount.toString();
      roomController.text = transaction.room.toString();
      isExpense = transaction.isExpense;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    amountController.dispose();
    roomController.dispose();
    otelnameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.transaction != null;
    final title = isEditing ? 'Rezervasyon Düzenle' : 'Rezervasyon Ekle';

    return AlertDialog(
      title: Text(title),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 8),
              buildName(),
              SizedBox(height: 8),
              buildAmount(),
              SizedBox(height: 8),
              buildRoom(),
              SizedBox(height: 8),
              buildOtelName(),
              SizedBox(height: 8),
              buildRadioButtons(),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        buildCancelButton(context),
        buildAddButton(context, isEditing: isEditing),
      ],
    );
  }

  Widget buildName() => TextFormField(
    controller: nameController,
    decoration: InputDecoration(
      border: OutlineInputBorder(),
      hintText: 'Adınızı Giriniz',
    ),
    validator: (name) =>
    name != null && name.isEmpty ? 'Adınızı Giriniz' : null,
  );

  Widget buildAmount() => TextFormField(
    decoration: InputDecoration(
      border: OutlineInputBorder(),
      hintText: 'Fiyatı Giriniz',
    ),
    keyboardType: TextInputType.number,
    validator: (amount) => amount != null && double.tryParse(amount) == null
        ? 'Enter a valid number'
        : null,
    controller: amountController,
  );
  Widget buildOtelName() => TextFormField(
    controller: otelnameController,
    decoration: InputDecoration(
      border: OutlineInputBorder(),
      hintText: 'Otel Adınız Giriniz',
    ),
    validator: (otelname) =>
    otelname != null && otelname.isEmpty ? 'Otel Adınız Giriniz' : null,
  );
  Widget buildRoom() => TextFormField(
    decoration: InputDecoration(
      border: OutlineInputBorder(),
      hintText: 'Oda Sayısını Girin... ',
    ),
    keyboardType: TextInputType.number,

    controller: roomController,
  );

  Widget buildRadioButtons() => Column(
    children: [

      RadioListTile<bool>(
        title: Text('Onaylıyorum'),
        value: false,
        groupValue: isExpense,
        onChanged: (value) => setState(() => isExpense = value!),
      ),
    ],
  );

  Widget buildCancelButton(BuildContext context) => TextButton(
    child: Text('İptal'),
    onPressed: () => Navigator.of(context).pop(),
  );

  Widget buildAddButton(BuildContext context, {required bool isEditing}) {
    final text = isEditing ? 'Kaydet' : 'Ekle';

    return TextButton(
      child: Text(text),
      onPressed: () async {
        final isValid = formKey.currentState!.validate();

        if (isValid) {
          final name = nameController.text;
          final otelname = otelnameController.text;
          final amount = double.tryParse(amountController.text) ?? 0;
          final room = int.tryParse(roomController.text)  ?? 0;

          widget.onClickedDone(name, amount, isExpense,otelname,room);

          Navigator.of(context).pop();
        }
      },
    );
  }
}