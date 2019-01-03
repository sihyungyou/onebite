// 버그신고

import 'package:Shrine/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'notice_detail.dart';
import 'bug_write.dart';

class BugReportPage extends StatefulWidget {
  final FirebaseUser user;
  BugReportPage({this.user});
  @override
  _BugReportPageState createState() => _BugReportPageState(user: this.user);
}

class _BugReportPageState extends State<BugReportPage> {
  @override
  Future _data;
  final FirebaseUser user;
  _BugReportPageState({this.user});

  Future getPosts() async {
    // instantiate my cloud firestore first
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("bug").getDocuments();
    return qn.documents;
  }

  navigateToDetail(DocumentSnapshot post) {
    Navigator.push(context,MaterialPageRoute(builder: (context) => NoticeDetailPage(post: post,)));
  }

  @override
  void initState() {
    // future: getPosts() 로 하면 매번 notice detail 에서 돌아올 때에도 계속 execute함. 그걸 해결하기 위해서
    super.initState();
    _data = getPosts(); // now, instead of call getpost every time, the future can simply use _data! no more re-render
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => HomePage(user:user)))
                    .catchError((e) => print(e)); 
          },
        ),
        title: Text("버그신고"),
        // +버튼 -> bug add 페이지 하나 만들기
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // go to write bug report page
              print('go to write bug report page');
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => WriteBugPage( user: user,))).catchError((e) => print(e));
            }
          )
        ],
      ),
      body: Container(
        child: FutureBuilder(
            //  future: getPosts(), 에서 future : _data로!
            future: _data,
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Text("Loading..."),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length, // actual length of returned data from future
                  itemBuilder: (_, index) {
                    return ListTile(
                      // length - index - 1 부터 display 한다는 것은 date 이 최근일 수록 list의 위로 오도록 sorting 함
                      title: Text(snapshot.data[snapshot.data.length-index-1].data["title"]),
                      subtitle: Text(snapshot.data[snapshot.data.length-index-1].data["date"] + " " + snapshot.data[snapshot.data.length-index-1].data["writer"]),
                      onTap: () => navigateToDetail(snapshot.data[snapshot.data.length-index-1]),
                    );
                  },
                );
              }
            }),
      ),
    );
  }
}