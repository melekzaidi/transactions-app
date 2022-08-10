import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import 'dart:math';

class transaction_item extends StatefulWidget {
  transaction_item({
    required Key key,
    required this.transaction,
    required this.deletetx,
  }) : super(key: key);

  // ignore: non_constant_identifier_names
  final Transaction transaction;
  final Function deletetx;

  @override
  State<transaction_item> createState() => _transaction_itemState();
}

class _transaction_itemState extends State<transaction_item> {
  late Color _bgcolor;

  void initState() {
    const avaivlecolors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.purple
    ];
    _bgcolor = avaivlecolors[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgcolor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: FittedBox(
                child: Text(
              "\$${widget.transaction.amount}",
              style: TextStyle(
                color: Colors.white,
              ),
            )),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text(DateFormat.yMMMEd().format(widget.transaction.date)),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          onPressed: () => this.widget.deletetx(widget.transaction.id),
        ),
      ),
    );
  }
}
