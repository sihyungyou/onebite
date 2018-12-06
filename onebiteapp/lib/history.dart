// 최근 이용한 한입만 식당
// 전체식당
import 'package:Shrine/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'rest_detail.dart';
import 'rest_all.dart';

class HistoryPage extends StatefulWidget {
  @override
  final FirebaseUser user;
  HistoryPage({Key key, this.user});
  _HistoryPageState createState() => _HistoryPageState(user: user);
}

class _HistoryPageState extends State<HistoryPage> {
  final FirebaseUser user;
  List<History> history = List<History>();
  List<Restaurant> historyList = List<Restaurant>();
  _HistoryPageState({Key key, this.user});

  Future _buildList() async {
    // print("buildlist in");
    QuerySnapshot favoriteSnapshot =
    await Firestore.instance.collection("users").document(user.uid).collection("history").getDocuments();
    var list1 = favoriteSnapshot.documents;
    for(var i = 0 ; i< list1.length; i ++){
      final History temp = History.fromSnapshot(list1[i]);
      // print("history" + i.toString() + " " + temp.name);
      history.add(temp);
    }

    QuerySnapshot querySnapshot =
    await Firestore.instance.collection("restaurant").getDocuments();
    var list = querySnapshot.documents;
    // build init 할 때 user collection -> uid document -> search_history collection -> index 돌면서 추가!

    setState(() {
      for (var i = 0; i < history.length; i++) {
        for(int j = 0; j< list.length; j++){
          final Restaurant restaurant = Restaurant.fromSnapshot(list[j]);
          if(restaurant.name == history[i].name) historyList.add(restaurant);
        }

      }
    });




  }

  @override
  void initState() {
    _buildList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: (){
            Navigator.of(context)
                .push(MaterialPageRoute(
                builder: (BuildContext context) =>
                    HomePage(
                        user: user,
                    )))
                .catchError((e) => print(e));
          },
        )
      ),
      body: ListView.builder(
        itemCount: historyList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: Image.network('${historyList[index].logo}').image,
            ),
              title: Text(historyList[index].name),
              subtitle: Text("영업시간: " + historyList[index].time),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            DetailPage(
                                user: user,
                                restaurant: historyList[index],
                                previous: "history")))
                    .catchError((e) => print(e));
              });
        }),
    );
  }
}
