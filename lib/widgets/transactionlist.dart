import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/transaction_item.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class Transactionlist extends StatelessWidget {
  late final List<Transaction> transaction;
  Function deletetx;
  Transactionlist(this.transaction, this.deletetx);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: transaction.isEmpty
            ? Image.network(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR41KhPtJ_iiZKBpmRhqaOGD7Tao_2u5HOsyQ&usqp=CAU")
            : ListView(children: [
                ...transaction
                    .map((tx) => transaction_item(
                        key: ValueKey(tx.id),
                        transaction: tx,
                        deletetx: deletetx))
                    .toList()
              ]));
  }
}
