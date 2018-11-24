import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailPage extends StatefulWidget {
  // final FirebaseUser user;
  
  // DetailPage({Key key, this.user});
  DetailPageState createState() => DetailPageState();
}

class DetailPageState extends State<DetailPage> {
  // final FirebaseUser user;
  // DetailPageState({Key key, this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text("${user.displayName}"),
        title: Text('test'),
      )
    );
  }
}
