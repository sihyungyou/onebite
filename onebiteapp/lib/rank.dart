// 전체식당
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'rest_detail.dart';
import 'rest_all.dart';

class RankPage extends StatefulWidget {
  @override
  final FirebaseUser user;
  List<Restaurant> sortedlist = new List<Restaurant>();
  RankPage({Key key, this.user, this.sortedlist});
  _RankPageState createState() => _RankPageState(user: user, sortedlist: sortedlist);
}

class _RankPageState extends State<RankPage> {
  final FirebaseUser user;
  List<Restaurant> sortedlist;
  _RankPageState({Key key, this.user, this.sortedlist});


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('한입만 맛집 랭킹'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: sortedlist.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              radius: 25.0,
              backgroundImage: Image.network('${sortedlist[index].logo}').image,
            ),
              title: Text(sortedlist[index].name),
              subtitle: Text("영업시간: " + sortedlist[index].time),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            DetailPage(
                                user: user,
                                restaurant: sortedlist[index])))
                    .catchError((e) => print(e));
              }
              );
        }),
    );
  }
}
