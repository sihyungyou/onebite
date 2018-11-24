// 전체식당
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class RestAllPage extends StatefulWidget {
  @override
  final FirebaseUser user;
  RestAllPage({Key key, this.user});
  _RestAllPageState createState() => _RestAllPageState(user: user);
}

class _RestAllPageState extends State<RestAllPage> {
  final FirebaseUser user;

  _RestAllPageState({Key key, this.user});



  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text("전체 식당")
  //     ),
  //     // body: new RestList(),
  //     body: new Column(
  //       children: <Widget>[
  //         Text('${user.displayName}, 리스트에 공간확보 테스팅'),
  //         Expanded(
  //           child: RestList(),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home : DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: <Widget>[
                Tab(text: '패스트푸드'),
                Tab(text: '한식'),
                Tab(text: '중식'),
                Tab(text: '일식'),
                Tab(text: '분식'),
              ],
            ),
            title: Text('전체 식당'),
          ),
          body: TabBarView(
            children: <Widget>[
              FastList(),
              KoreanList(),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
              Icon(Icons.directions_boat),
            ],
          ),
        ),
      )
    );
  }
}

class KoreanList extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return new StreamBuilder(
      stream: Firestore.instance.collection('restaurants').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(!snapshot.hasData) return new Text('Loading...');
        return new ListView(
          children: snapshot.data.documents.map((document) {
            print(document['type']);
            if (document['type'] == 'korean') {
              return new ListTile(
              // 사진
              // 업체명
              // 영업시간
              // 배달비 여부
              // favorite icon
              title: new Text(document['name']),
              subtitle: new Text(document['time']),
              onTap: () {
                // go to rest-detail page
              },
            );
            } else {
              return ListTile(
                title: new Text('not korean'),
                subtitle: new Text('how to get this out of listview..'),
              );
            }
          }).toList()
        );
      },
    );
  }
}

class FastList extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return new StreamBuilder(
      stream: Firestore.instance.collection('restaurants').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(!snapshot.hasData) return new Text('Loading...');
        return new ListView(
          children: snapshot.data.documents.map((document) {
            print(document['type']);
            if (document['type'] == 'fastfood') {
              return new ListTile(
              // 사진
              // 업체명
              // 영업시간
              // 배달비 여부
              // favorite icon
              title: new Text(document['name']),
              subtitle: new Text(document['time']),
              onTap: () {
                // go to rest-detail page
              },
            );
            } else {
              return ListTile(
                title: new Text('not fastfood'),
                subtitle: new Text('how to get this out of listview..'),
              );
            }
          }).toList()
        );
      },
    );
  }
}