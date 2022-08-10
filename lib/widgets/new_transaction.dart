import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/main.dart';
import 'package:intl/intl.dart';

class new_transaction extends StatefulWidget {
  final Function addtx;

  new_transaction(this.addtx);

  @override
  State<new_transaction> createState() => _new_transactionState();
}

class _new_transactionState extends State<new_transaction> {
  final _titleContoller = TextEditingController();
  DateTime? _submitdate;
  final _amountContoller = TextEditingController();
  void cancel() {
    Navigator.pop(context);
  }

  void _submitData() {
    final title = _titleContoller.text;
    final amount = double.parse(_amountContoller.text);
    if ((title == "") || (amount <= 0) || (_submitdate == null)) {
      return;
    }
    this.widget.addtx(title, amount, _submitdate);
    Navigator.pop(context);
  }

  void _presentDatepicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }

      setState(() {
        _submitdate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      height: 50,
                      width: WidgetsBinding.instance.window.physicalSize.width *
                          0.5,
                      child: TextField(
                        controller: _titleContoller,
                        decoration: InputDecoration(labelText: "title"),
                        textAlign: TextAlign.center,
                      )),
                  Container(
                      height: 50,
                      width: WidgetsBinding.instance.window.physicalSize.width *
                          0.5,
                      child: TextField(
                        controller: _amountContoller,
                        decoration: InputDecoration(labelText: "amount"),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        onSubmitted: (_) => _submitData,
                      )),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(_submitdate == null
                            ? "no date chosen"
                            : "${DateFormat.yMd().format(_submitdate!)}"),
                        TextButton(
                            onPressed: _presentDatepicker,
                            child: Text("choose date",
                                style: TextStyle(fontWeight: FontWeight.bold)))
                      ]),
                  TextButton(
                      onPressed: _submitData,
                      child: Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Add Transaction",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 20),
                          ))),
                  TextButton(
                      onPressed: cancel,
                      child: Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "cancel",
                            style: TextStyle(color: Colors.red, fontSize: 20),
                          ))),
                ]),
          ),
        ));
  }
}
