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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("전체 식당")
      ),
      body: new RestList(),
    );
  }
}

class RestList extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return new StreamBuilder(
      stream: Firestore.instance.collection('restaurants').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(!snapshot.hasData) return new Text('Loading...');
        return new ListView(
          children: snapshot.data.documents.map((document) {
            return new ListTile(
              title: new Text(document['name']),
              subtitle: new Text(document['time']),
            );
          }).toList()
        );
      },
    );
  }
}