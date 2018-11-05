import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
// import 'package:flutter/rendering.dart'  show debugPaintSizeEnabled;

class SearchPage extends StatefulWidget {
  @override
  SearchPageState createState() => new SearchPageState();
}

class MyItem1 {
  MyItem1({this.isExpanded: false, this.header, this.middle, this.body});

  bool isExpanded;
  final String header;
  final String middle;
  final String body;
}

class MyItem2 {
  MyItem2({this.isExpanded: false, this.header, this.middle, this.body});
  bool isExpanded;
  final String header;
  final String middle;
  final String body;
}

enum Locations { Seoul, Busan, Daegu }
enum Rooms { Single, Double, Family }
enum MyDialogAction { Search, Cancel }

class SearchPageState extends State<SearchPage> {
  double _value = 0.0;
  String checkin = '';
  String checkout = '';
  String checkintime = '';
  String checkouttime = '';
  String selected_location = '';
  String selected_hotel = '';
  String selected_checkindate = '';
  String selected_checkintime = '';
  String selected_checkoutdate = '';
  String selected_checkouttime = '';
  bool star1 = false;
  bool star2 = false;
  bool star3 = false;
  bool star4 = false;
  bool star5 = false;
  bool isExpanded1 = false;
  bool isExpanded2 = false;
  bool isExpanded3 = false;
  bool switchvalue = false;
  bool value1 = false;
  bool value2 = false;
  bool value3 = false;
  bool value4 = false;
  bool value5 = false;
  DateTime _date1 = new DateTime.now();
  DateTime _date2 = new DateTime.now();
  TimeOfDay _time1 = new TimeOfDay.now();
  TimeOfDay _time2 = new TimeOfDay.now();
  onChanged(double value) {
    setState(() {
      _value = value;
      print(_value);
    });
  }

  Future<Null> _selectcheckinDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date1,
        firstDate: new DateTime(2016),
        lastDate: new DateTime(2019));
    if (picked != null && picked != _date1) {
      setState(() {
        _date1 = picked;
      });
      print('Date selected : ${_date1.toString()}');
    }

    checkin = DateFormat.yMMMd().format(_date1);
  }

  Future<Null> _selectcheckoutDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date2,
        firstDate: new DateTime(2016),
        lastDate: new DateTime(2019));
    if (picked != null && picked != _date1) {
      setState(() {
        _date2 = picked;
      });
      print('Date selected : ${_date2.toString()}');
    }

    checkout = DateFormat.yMMMd().format(_date2);
  }

  Future<Null> _selectcheckinTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _time1,
    );
    if (picked != null && picked != _time1) {
      setState(() {
        _time1 = picked;
      });
      print('Time selected : ${_time1.toString()}');
    }

    // checkintime = '${_time1.toString()}';
    checkintime = _time1.format(context);
    print(checkintime);
  }

  Future<Null> _selectcheckoutTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _time2,
    );
    if (picked != null && picked != _time2) {
      setState(() {
        _time2 = picked;
      });
      print('Time selected : ${_time2.toString()}');
    }

    // checkouttime = '${_time2.toString()}';
    checkouttime = _time2.format(context);
    print(checkouttime);
  }

  Locations _location = Locations.Seoul;
  Rooms _rooms = Rooms.Single;

  void _dialogResult(MyDialogAction value) {
    print('selected $value');
    Navigator.pop(context);
  }

  void _showAlert() {
    AlertDialog dialog = new AlertDialog(
      content: Container(
        height: 300.0,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  // height: 100.0,
                  // width: 286.0,
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 100.0,
                        width: 286.0,
                        color: Colors.lightBlue,
                        child: Text(
                          'Please check your choice :)', 
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                          )
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  height: 30.0,
                )
              ],
            ), //space
            //location
            Row(
              children: <Widget>[
                Container(
                  width: 30.0,
                ),
                Container(
                    width: 100.0,
                    child: Row(children: <Widget>[
                      Icon(
                        Icons.location_on,
                        color: Colors.lightBlue,
                      ),
                    ])),
                Container(
                  child: Text(selected_location),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  height: 15.0,
                )
              ],
            ), //space
            //room selection
            Row(
              children: <Widget>[
                Container(
                  width: 30.0,
                ),
                Container(
                    width: 100.0,
                    child: Row(children: <Widget>[
                      Icon(
                        Icons.hotel,
                        color: Colors.lightBlue,
                      ),
                    ])),
                Container(
                  child: Text(selected_hotel),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  height: 15.0,
                )
              ],
            ), //space
            //stars
            Row(
              children: <Widget>[
                Container(
                  width: 30.0,
                ),
                Container(
                    width: 45.0,
                    child: Row(
                      children: <Widget>[
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      
                    ])
                ),
                //check bool type and display how many stars
                Expanded(
                  // width: 220.0,
                  child: Row(
                    children: <Widget>[
                  star1 ? Row(children: <Widget> [
                    Icon(Icons.star, color: Colors.yellow,),
                    Text('/'),
                   ],) : Text(''),
                  star2 ? Row(children: <Widget>[
                    Icon(Icons.star, color: Colors.yellow,),
                    Icon(Icons.star, color: Colors.yellow,),
                    Text('/'),
                  ],) : Text(''),
                  star3 ? Row(children: <Widget>[
                    Icon(Icons.star, color: Colors.yellow,),
                    Icon(Icons.star, color: Colors.yellow,),
                    Icon(Icons.star, color: Colors.yellow,),
                    Text('/'),
                  ],) : Text(''),
                  star4 ? Row(children: <Widget>[
                    Icon(Icons.star, color: Colors.yellow,),
                    Icon(Icons.star, color: Colors.yellow,),
                    Icon(Icons.star, color: Colors.yellow,),
                    Icon(Icons.star, color: Colors.yellow,),
                    Text('/'),
                  ],) : Text(''),
                  star5 ? Row(children: <Widget>[
                    Icon(Icons.star, color: Colors.yellow,),
                    Icon(Icons.star, color: Colors.yellow,),
                    Icon(Icons.star, color: Colors.yellow,),
                    Icon(Icons.star, color: Colors.yellow,),
                    Icon(Icons.star, color: Colors.yellow,),
                    Text('/'),
                  ],) : Text(''),
                      ],)
                      )
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  height: 15.0,
                )
              ],
            ), //space
            //checkin, out date and time
            Row(
              children: <Widget>[
                Container(
                  width: 30.0,
                ),
                Container(
                    width: 45.0,
                    child: Row(children: <Widget>[
                      Icon(
                        Icons.calendar_today,
                        color: Colors.lightBlue,
                      ),
                    ])),
                Row(children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget> [
                        Row(
                          children: <Widget>[
                          Text('in ',style: TextStyle( fontSize: 12.0),),
                          Text(selected_checkindate,style: TextStyle( fontSize: 12.0),),
                          Text(selected_checkintime,style: TextStyle( fontSize: 12.0),),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                          Text('out ',style: TextStyle( fontSize: 12.0),),
                          Text(selected_checkoutdate,style: TextStyle( fontSize: 12.0),),
                          Text(selected_checkouttime,style: TextStyle( fontSize: 12.0),),
                          ],
                        ),
                      ]
                    ),
                ),
                ],),
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        new FlatButton(
          color: Colors.lightBlue,
          textColor: Colors.white,
          onPressed: () {
            _dialogResult(MyDialogAction.Search);
          },
          child: new Text('Search'),
        ),
        new FlatButton(
          color: Colors.grey,
          textColor: Colors.white,
          onPressed: () {
            _dialogResult(MyDialogAction.Cancel);
          },
          child: new Text('Cancel',),
        ),
      ],
    );
    showDialog(context: context, child: dialog);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Search'),
      ),
      body: new ListView(
        children: [
          new ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              print(index);
              setState(() {
                if (index == 0) isExpanded1 = !isExpanded1;
                if (index == 1) isExpanded2 = !isExpanded2;
                if (index == 2) isExpanded3 = !isExpanded3;
              });
            },
            children : <ExpansionPanel> [
              new ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded1){
                  return new Container(
                    child: Row (children: <Widget>[
                      Container(
                        width: 200.0,
                        child: Text('Location'),
                      ),
                      Text('select hotel'),
                    ],),
                  );
                },
                isExpanded: isExpanded1,
                body: new Container(
                  child: Row (children: <Widget>[
                    Container (
                      width : 170.0,
                    ),
                    Container(
                      width: 200.0,
                      child: Column (
                        children : <Widget> [
                          RadioListTile<Locations>(
                              title: const Text('Seoul'),
                              value: Locations.Seoul,
                              groupValue: _location,
                              onChanged: (Locations value) {
                                setState(() {
                                  _location = value;
                                  selected_location = 'Seoul';
                                });
                              },
                            ),
                            RadioListTile<Locations>(
                              title: const Text('Daegu'),
                              value: Locations.Daegu,
                              groupValue: _location,
                              onChanged: (Locations value) {
                                setState(() {
                                  _location = value;
                                  selected_location = 'Daegu';
                                });
                              },
                            ),
                            RadioListTile<Locations>(
                              title: const Text('Busan'),
                              value: Locations.Busan,
                              groupValue: _location,
                              onChanged: (Locations value) {
                                setState(() {
                                  _location = value;
                                  selected_location = 'Busan';
                                });
                              },
                            )
                        ]
                      )
                    )
                  ],)
                )
              ),
              new ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded2) {
                  return new Container(
                    child: Row(children: <Widget>[
                      Container(
                        width: 200.0,
                        child: Text('Room'),
                      ),
                      Text('select room'),
                    ]),
                  );
                },
                isExpanded: isExpanded2,
                body: new Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        //this container is for the blank 200 pixel before the radio buttons
                        width: 170.0,
                      ),
                      Container(
                        //actual radio buttons container
                        width: 200.0,
                        child: Column(
                          children: <Widget>[
                            RadioListTile<Rooms>(
                              title: const Text('Single'),
                              value: Rooms.Single,
                              groupValue: _rooms,
                              onChanged: (Rooms value) {
                                setState(() {
                                  _rooms = value;
                                  selected_hotel = 'Single';
                                });
                              },
                            ),
                            RadioListTile<Rooms>(
                              title: const Text('Double'),
                              value: Rooms.Double,
                              groupValue: _rooms,
                              onChanged: (Rooms value) {
                                setState(() {
                                  _rooms = value;
                                  selected_hotel = 'Double';
                                });
                              },
                            ),
                            RadioListTile<Rooms>(
                              title: const Text('Family'),
                              value: Rooms.Family,
                              groupValue: _rooms,
                              onChanged: (Rooms value) {
                                setState(() {
                                  _rooms = value;
                                  selected_hotel = 'Family';
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              new ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded3) {
                  return new Container(
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 200.0,
                              child: Text('Class'),
                            ),
                            Text('select hotel classes'),
                          ],
                        ),
                      );
                },
                isExpanded: isExpanded3,
                body: Container(
                        //checkbox list tile
                        //column-row
                        child: Column(children: <Widget>[
                      new CheckboxListTile(
                        value: value1,
                        onChanged: (value) {
                          setState(() {
                            value1 = value;
                            star1 = true;
                          });
                        },
                        title: Row(
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            )
                          ],
                        ),
                      ),
                      new CheckboxListTile(
                        value: value2,
                        onChanged: (value) {
                          setState(() {
                            value2 = value;
                            star2 = true;
                          });
                        },
                        title: Row(
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            )
                          ],
                        ),
                      ),
                      new CheckboxListTile(
                        value: value3,
                        onChanged: (value) {
                          setState(() {
                            value3 = value;
                            star3 = true;
                          });
                        },
                        title: Row(
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            )
                          ],
                        ),
                      ),
                      new CheckboxListTile(
                        value: value4,
                        onChanged: (value) {
                          setState(() {
                            value4 = value;
                            star4 = true;
                          });
                        },
                        title: Row(
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            )
                          ],
                        ),
                      ),
                      new CheckboxListTile(
                        value: value5,
                        onChanged: (value) {
                          setState(() {
                            value5 = value;
                            star5 = true;
                          });
                        },
                        title: Row(
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            )
                          ],
                        ),
                      ),
                    ]))
              )
            ],
          ),
          //date
          Container(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 50.0,
                    ),
                    Text('Date'),
                    Container(
                      width: 70.0,
                    ),
                    Text(
                      'i don\'t have specific dates yet',
                      style:
                          const TextStyle(fontSize: 10.0, color: Colors.grey),
                    ),
                    Switch(
                      onChanged: (value) {
                        setState(() {
                          switchvalue = value;
                        });
                      },
                      value: switchvalue,
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: 40.0,
                    ),
                    Icon(
                      Icons.calendar_today,
                      color: Colors.blue,
                    ),
                    Container(width: 180.0, child: Text('check-in')),
                    RaisedButton(
                      child: Text('select date'),
                      color: Colors.lightBlue,
                      onPressed: switchvalue
                          ? () {
                              //pop up calendar
                              _selectcheckinDate(context);
                              selected_checkindate = checkin;
                            }
                          : null,
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(width: 40.0),
                    Container(
                        child: Row(
                      children: <Widget>[
                        Container(
                          width: 102.5,
                          child: Text(checkin),
                        ),
                        Container(
                          width: 102.5,
                          child: Text(checkintime),
                        )
                      ],
                    )),
                    RaisedButton(
                      child: Text('select time'),
                      color: Colors.lightBlue,
                      onPressed: switchvalue
                          ? () {
                              //pop up time
                              _selectcheckinTime(context);
                              selected_checkintime = checkintime;
                            }
                          : null,
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: 40.0,
                    ),
                    Icon(
                      Icons.calendar_today,
                      color: Colors.blue,
                    ),
                    Container(width: 180.0, child: Text('check-out')),
                    RaisedButton(
                      child: Text('select date'),
                      color: Colors.lightBlue,
                      onPressed: switchvalue
                          ? () {
                              //pop up calendar
                              _selectcheckoutDate(context);
                              selected_checkoutdate = checkout;
                            }
                          : null,
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(width: 40.0),
                    Container(
                        child: Row(
                      children: <Widget>[
                        Container(width: 102.5, child: Text(checkout)),
                        Container(
                          width: 102.5,
                          child: Text(checkouttime),
                        )
                      ],
                    )),
                    RaisedButton(
                      child: Text('select time'),
                      color: Colors.lightBlue,
                      onPressed: switchvalue
                          ? () {
                              //pop up time
                              _selectcheckoutTime(context);
                              selected_checkouttime = checkouttime;
                            }
                          : null,
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
              height: 50.0,
              child: Row(
                children: <Widget>[
                  Container(
                    width: 50.0,
                  ),
                  SizedBox(
                    width: 250.0,
                    child: Text('Fee'),
                  ),
                  Text('Up to \$$_value'),
                ],
              )),
          Container(
            height: 50.0,
            child: Row(
              children: <Widget>[
                Container(
                  width: 120.0,
                ),
                Container(
                  child: Slider(
                    value: _value,
                    onChanged: onChanged,
                    divisions: 10,
                    max: 100.0,
                    min: 0.0,
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  width: 150.0,
                ),
                RaisedButton(
                    child: Text('Search'),
                    color: Colors.lightBlue,
                    onPressed: () {
                      _showAlert();
                    })
              ],
            ),
          )
        ], //children in listview
      ),
    );
  } //widget build
}
