import 'package:Register/widgets/gridlist/transactions.dart';
import 'package:Register/widgets/text/header.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:Register/widgets/nav/drawer.dart';
import 'package:Register/widgets/nav/navbar.dart';
import 'package:Register/store/edit_trans.dart';
import 'package:provider/provider.dart';
import 'package:Register/models/transaction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Register/services/firestore_service.dart';
import 'package:Register/widgets/forms/form.dart';
import 'package:intl/intl.dart';

class ViewTransPage extends StatefulWidget {
  static const String routeName = '/viewtrans';
  @override
  _ViewTransPageState createState() => _ViewTransPageState();
}

class _ViewTransPageState extends State<ViewTransPage> {
  final fire = FirestoreService();
  final TextEditingController _date = TextEditingController();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  var today;
  var _transId;
  var _transDate;
  //var now = formatter.format(DateTime.now());
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  int currentTimeInSeconds(now) {
    var ms = (formatter.parse(now)).millisecondsSinceEpoch;
    return (ms / 1000).round();
  }

  //@override

  @override
  Widget build(BuildContext context) {
    void editSupplier() {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => TransPage()));
    }

    _db
        .collection('transx')
        .get()
        .then((value) => value.docs.forEach((element) {
              print(element.data()['transId']);
            }));

    //print(firstDateOfThisWeek() + " | " + firstDateOfNextWeek());
    // print(currentTimeInSeconds(
    //         formatter.format(DateTime.now().add(Duration(days: 1))))
    //     .toString());

    transToday();
    void searchbar() {}
    return Scaffold(
      appBar:
          NavBar(IconButton(icon: Icon(Icons.search), onPressed: searchbar)),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          pageHeader(text: 'All Transactions'),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(0),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              //child: TransList(),
              //child: Text(today.toString()),
              child: SafeArea(
                child: DefaultTabController(
                  length: 5,
                  child: Column(
                    children: <Widget>[
                      ButtonsTabBar(
                        backgroundColor: Colors.red,
                        unselectedBackgroundColor: Colors.grey[300],
                        unselectedLabelStyle: TextStyle(color: Colors.black),
                        labelStyle: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        tabs: [
                          Tab(
                            // icon: Icon(Icons.directions_car),
                            text: "All",
                          ),
                          Tab(
                            // icon: Icon(Icons.directions_transit),
                            text: "Today",
                          ),
                          Tab(
                            // icon: Icon(Icons.directions_transit),
                            text: "This Week",
                          ),
                          Tab(
                            // icon: Icon(Icons.directions_transit),
                            text: "This Month",
                          ),
                          Tab(
                            // icon: Icon(Icons.directions_transit),
                            text: "This Year",
                          ),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: <Widget>[
                            // Center(
                            //   child: Icon(Icons.directions_car),
                            // ),

                            Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 5, bottom: 5, left: 20, right: 20),
                                  child: inputTextFieldWithSuffixButton(
                                    label: 'Search Order Number or Order Date',
                                    controller: _date,
                                    iconbutton: IconButton(
                                      icon: Icon(Icons.calendar_today_outlined),
                                      onPressed: () {
                                        _datePicker(context);
                                      },
                                    ),
                                    onChange: (value) {
                                      setState(
                                        () {
                                          (_transDate == null ||
                                                  _transDate == "")
                                              ? _transId = value.toString()
                                              : _transDate = value.toString();
                                        },
                                      );
                                    },
                                  ),
                                ),
                                (_transId == "" || _transId == null)
                                    ? (_transDate == null || _transDate == "")
                                        ? Expanded(
                                            child: ListTransactions(),
                                          )
                                        : Expanded(
                                            child: StreamProvider<
                                                List<ProductTrans>>.value(
                                              value: fire.byTransField(
                                                  'transDate',
                                                  _transDate.toString()),
                                              child: ListTransactions(),
                                            ),
                                          )
                                    : Expanded(
                                        child: StreamProvider<
                                            List<ProductTrans>>.value(
                                          value: fire.byTransField(
                                              'transId', _transId.toString()),
                                          child: ListTransactions(),
                                        ),
                                      ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Center(
                                  child: Text(
                                    DateFormat.yMMMEd()
                                        .format(DateTime.now())
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                  child:
                                      StreamProvider<List<ProductTrans>>.value(
                                    value: fire.byToday(dateNow().toString()),
                                    child: ListTransactions(),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Center(
                                  child: Text(
                                    DateFormat.yMMMEd()
                                            .format(DateTime.now().subtract(
                                                Duration(
                                                    days:
                                                        DateTime.now().weekday -
                                                            1)))
                                            .toString() +
                                        " - " +
                                        DateFormat.yMMMEd()
                                            .format(DateTime.now().add(Duration(
                                                days: DateTime.now().weekday -
                                                    5)))
                                            .toString(),
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                  // child:
                                  //     StreamProvider<List<ProductTrans>>.value(
                                  //   value: fire.byDate(firstDateOfThisWeek(),
                                  //       firstDateOfNextWeek()),
                                  //   child: ListTransactions(),
                                  // ),
                                  child: Center(
                                    child: Text("COMING SOON..."),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Center(
                                  child: Text(
                                    DateFormat.yMMMEd()
                                            .format(new DateTime(
                                              DateTime.now().year,
                                              DateTime.now().month,
                                              1,
                                            ))
                                            .toString() +
                                        " - " +
                                        DateFormat.yMMMEd()
                                            .format(new DateTime(
                                              DateTime.now().year,
                                              DateTime.now().month + 1,
                                              0,
                                            ))
                                            .toString(),
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                    // child:
                                    //     StreamProvider<List<ProductTrans>>.value(
                                    //   value: fire.byDate(firstDateOfThisMonth(),
                                    //       firstDateOfNextMonth()),
                                    //   child: ListTransactions(),
                                    // ),
                                    child: Center(
                                  child: Text("COMING SOON..."),
                                )),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Center(
                                  child: Text(
                                    DateFormat.yMMMEd()
                                            .format(new DateTime(
                                              DateTime.now().year,
                                              1,
                                            ))
                                            .toString() +
                                        " - " +
                                        DateFormat.yMMMEd()
                                            .format(new DateTime(
                                              DateTime.now().year + 1,
                                              1,
                                            ))
                                            .toString(),
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                    // child:
                                    //     StreamProvider<List<ProductTrans>>.value(
                                    //   value: fire.byDate(firstDateOfThisYear(),
                                    //       firstDateOfNextYear()),
                                    //   child: ListTransactions(),
                                    // ),
                                    child: Center(
                                  child: Text("COMING SOON..."),
                                )),
                              ],
                            ),
                            // Center(
                            //   child: Icon(Icons.directions_transit),
                            // ),
                            // Center(
                            //   child: Icon(Icons.directions_bike),
                            // ),
                            // Center(
                            //   child: Icon(Icons.directions_car),
                            // ),
                            // Center(
                            //   child: Icon(Icons.directions_transit),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      drawer: Drawer(child: NavDrawer()),
      floatingActionButton: FloatingActionButton(
        onPressed: editSupplier,
        tooltip: 'Add new transaction',
        child: Icon(Icons.add),
      ),
    );
  }

  dateNow() {
    return formatter.format(DateTime.now()).toString();
  }

  todayDate() {
    return currentTimeInSeconds(formatter.format(DateTime.now())).toString();
  }

  tomorrowDate() {
    return currentTimeInSeconds(
            formatter.format(DateTime.now().add(Duration(days: 1))))
        .toString();
  }

  firstDateOfThisWeek() {
    var d = DateTime.now();
    var weekDay = d.weekday;
    DateTime firstDay = d.subtract(Duration(days: weekDay - 1));

    //print(formatter.format(firstDay));
    //return currentTimeInSeconds(formatter.format(firstDay)).toString();
    return formatter.format(firstDay).toString();
  }

  firstDateOfNextWeek() {
    var d = DateTime.now();
    var weekDay = d.weekday;
    DateTime firstDay = d.add(Duration(days: weekDay - 5));
    //print(formatter.format(firstDay));
    //return currentTimeInSeconds(formatter.format(firstDay)).toString();
    return formatter.format(firstDay).toString();
  }

  firstDateOfThisMonth() {
    DateTime firstDay = new DateTime(
      DateTime.now().year,
      DateTime.now().month,
      1,
    );
    print(firstDay);
    //return currentTimeInSeconds(formatter.format(firstDay)).toString();
    return formatter.format(firstDay).toString();
  }

  firstDateOfNextMonth() {
    DateTime firstDay = new DateTime(
      DateTime.now().year,
      DateTime.now().month + 1,
      0,
    );
    print(firstDay);
    //return currentTimeInSeconds(formatter.format(firstDay)).toString();
    return formatter.format(firstDay).toString();
  }

  firstDateOfThisYear() {
    DateTime firstDay = new DateTime(
      DateTime.now().year,
      1,
    );
    print(firstDay);
    //return currentTimeInSeconds(formatter.format(firstDay)).toString();
    return formatter.format(firstDay).toString();
  }

  firstDateOfNextYear() {
    DateTime firstDay = new DateTime(
      DateTime.now().year + 1,
      1,
    );
    print(firstDay);
    // return currentTimeInSeconds(formatter.format(firstDay)).toString();
    return formatter.format(firstDay).toString();
  }

  transToday() {
    _db
        .collection('trans')
        //.where('transId', isGreaterThanOrEqualTo: '1')
        .where('orderNo', isGreaterThanOrEqualTo: todayDate())
        .where('orderNo', isLessThanOrEqualTo: tomorrowDate())
        .get()
        .then((value) => {
              setState(() {
                today = value.docs.length.toString();
              })
            });
  }

  _datePicker(BuildContext context) async {
    final DateTime _pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light(), // This will change to light theme.
          child: child,
        );
      },
    );
    if (_pickedDate != null) {
      setState(() {
        _date.text = formatter.format(_pickedDate).toString();
        _transDate = formatter.format(_pickedDate).toString();
      });
    }
  }
}
