// 최근 이용한 한입만 식당
// 전체식당
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'rest_detail.dart';
import 'rest_all.dart';

class HistoryPage extends StatefulWidget {
  @override
  final FirebaseUser user;
  List<Restaurant> history = new List<Restaurant>();
  HistoryPage({Key key, this.user, this.history});
  _HistoryPageState createState() => _HistoryPageState(user: user, history: history);
}

class _HistoryPageState extends State<HistoryPage> {
  final FirebaseUser user;
  List<Restaurant> history;
  _HistoryPageState({Key key, this.user, this.history});


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              radius: 25.0,
              backgroundImage: Image.network('${history[index].logo}').image,
            ),
              title: Text(history[index].name),
              subtitle: Text("영업시간: " + history[index].time),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            DetailPage(
                                user: user,
                                restaurant: history[index])))
                    .catchError((e) => print(e));
              });
        }),
    );
  }
}
