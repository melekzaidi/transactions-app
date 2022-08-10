// ignore: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:flutter_application_1/models/transaction.dart';
import 'package:flutter_application_1/widgets/chart.dart';
import 'package:flutter_application_1/widgets/new_transaction.dart';
import 'package:flutter_application_1/widgets/transactionlist.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _showchart = false;
  List<Transaction> _userTrasaction = [];
  List<Transaction> get _recentTransaction {
    return _userTrasaction.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addtransaction(String t, double a, DateTime chosendate) {
    final newTx = Transaction(
        id: (DateTime.now()).toString(), title: t, amount: a, date: chosendate);
    setState(() {
      _userTrasaction.add(newTx);
    });
  }

  void _startnewtx(BuildContext ctx) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => new_transaction(_addtransaction)),
    );

    /*
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(child: new_transaction(_addtransaction));
        });*/
  }

  void deletetx(String id) {
    setState(() {
      _userTrasaction.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appbar = AppBar(
      title: Text(
        "Transaction app",
        style: TextStyle(fontFamily: 'OpenSans'),
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => new_transaction(_addtransaction)),
            );
          },
          icon: Icon(
            Icons.add,
          ),
        )
      ],
    );

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.purple, fontFamily: 'QuickSand'),
        home: Builder(builder: (BuildContext context) {
          return Scaffold(
              appBar: AppBar(
                title: Text(
                  "Transaction app",
                  style: TextStyle(fontFamily: 'OpenSans'),
                ),
                actions: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                new_transaction(_addtransaction)),
                      );
                    },
                    icon: Icon(
                      Icons.add,
                    ),
                  )
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                        height: (MediaQuery.of(context).size.height -
                                appbar.preferredSize.height -
                                MediaQuery.of(context).padding.top) *
                            0.1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("show chart"),
                            Switch.adaptive(
                                value: _showchart,
                                onChanged: (value) {
                                  setState(() {
                                    _showchart = value;
                                  });
                                })
                          ],
                        )),
                    MediaQuery.of(context).orientation == Orientation.landscape
                        ? _showchart
                            ? Column(
                                children: [
                                  Container(
                                      height:
                                          (MediaQuery.of(context).size.height -
                                                  appbar.preferredSize.height -
                                                  MediaQuery.of(context)
                                                      .padding
                                                      .top) *
                                              0.5,
                                      child: Chart(_recentTransaction)),
                                  Container(
                                      height:
                                          (MediaQuery.of(context).size.height -
                                                  appbar.preferredSize.height -
                                                  MediaQuery.of(context)
                                                      .padding
                                                      .top) *
                                              0.65,
                                      child: Transactionlist(
                                          _userTrasaction, deletetx)),
                                ],
                              )
                            : Container(
                                height: (MediaQuery.of(context).size.height -
                                        appbar.preferredSize.height -
                                        MediaQuery.of(context).padding.top) *
                                    0.7,
                                child:
                                    Transactionlist(_userTrasaction, deletetx))
                        : _showchart
                            ? Column(
                                children: [
                                  Container(
                                      height:
                                          (MediaQuery.of(context).size.height -
                                                  appbar.preferredSize.height -
                                                  MediaQuery.of(context)
                                                      .padding
                                                      .top) *
                                              0.25,
                                      child: Chart(_recentTransaction)),
                                  Container(
                                      height:
                                          (MediaQuery.of(context).size.height -
                                                  appbar.preferredSize.height -
                                                  MediaQuery.of(context)
                                                      .padding
                                                      .top) *
                                              0.65,
                                      child: Transactionlist(
                                          _userTrasaction, deletetx)),
                                ],
                              )
                            : Container(
                                height: (MediaQuery.of(context).size.height -
                                        appbar.preferredSize.height -
                                        MediaQuery.of(context).padding.top) *
                                    0.7,
                                child:
                                    Transactionlist(_userTrasaction, deletetx))
                  ],
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => new_transaction(_addtransaction)),
                  );
                },
                child: Icon(Icons.add),
              ));
        }));
  }
}
/*class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var indq = 0;
    void addqt() {
      indq++;
      print(indq);
    }

    var qt = [
      "what\'s your favourite color ?",
      "what\'s your favourite animal ?"
    ];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Text("my first app"),
          ),
          body: Column(
            children: [
              Container(
                child: Text(qt[indq]),
                margin: EdgeInsets.all(10),
              ),
              Container(
                child: ElevatedButton(onPressed: addqt, child: Text("onpress")),
                margin: EdgeInsets.all(10),
              ),
              Container(
                child: ElevatedButton(onPressed: null, child: Text("onpress")),
                margin: EdgeInsets.all(10),
              ),
              Container(
                child: ElevatedButton(onPressed: null, child: Text("onpress")),
                margin: EdgeInsets.all(10),
              ),
            ],
          )),
    );
  }
}*/

/*


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
*/
