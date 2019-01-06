// 버그신고 디테일
import 'package:Shrine/bug_report.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BugReportDetailPage extends StatefulWidget {
  final DocumentSnapshot post;
  final FirebaseUser user;

  BugReportDetailPage({this.post, this.user});

  @override
  _BugReportDetailPageState createState() => _BugReportDetailPageState();
}

class _BugReportDetailPageState extends State<BugReportDetailPage> {
  @override
  Widget build(BuildContext conte4xt) {
    return Scaffold(
      appBar: AppBar(
        title: Text("버그신고"),
        actions: <Widget>[
          widget.user.uid == widget.post.data["uid"] ? // 들어온 사람의 uid와 버그가 쓰여진 uid가 같으면 삭제 가능토록.
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // 이 버그내용 삭제
              Firestore.instance.runTransaction((transaction) async {
                DocumentSnapshot snapshot = await transaction.get(widget.post.reference);
                await transaction.delete(snapshot.reference);
                // print('deleted');
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: new Text('삭제되었습니다'),
                      actions: <Widget>[
                        new FlatButton(
                          child: new Text('Close'),
                          onPressed: () {
                            Navigator.of(context).pop();      // 첫번째로는 pop을 해서 alert dialog 창을 없앰
                            // 그런데 삭제 후 bug들을 list up 하는 페이지에서는 데이터를 stream을 한번 받아야 하기 때문에 pop이 아니라 push 로!
                            Navigator.of(context).push(MaterialPageRoute(
                             builder: (BuildContext context) =>  BugReportPage( user: widget.user,))).catchError((e) => print(e));
                          },
                        )
                      ],
                    );
                  }
                );
              });
            },
          ) :
          SizedBox(height: 1.0, width: 1.0,),
        ],
      ),
      body: Container(
        // 여기는 display 틀만 잡으면 끝!
        child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: Text(widget.post.data["title"]),
                  subtitle: Text(widget.post.data["date"]),
                ),
                Divider(),
                widget.post.data["image"] == "" ? //image 없으면
                SizedBox(height: 1.0,) :
                Image.network('${widget.post.data["image"]}', height: 250.0, width: 300.0,),
                ListTile(
                  title: Text(widget.post.data["content"]),
                )
              ],
            )),
      ),
    );
  }
}
