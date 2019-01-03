// 버그신고 디테일
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BugReportDetailPage extends StatefulWidget {
  final DocumentSnapshot post;

  BugReportDetailPage({this.post});

  @override
  _BugReportDetailPageState createState() => _BugReportDetailPageState();
}

class _BugReportDetailPageState extends State<BugReportDetailPage> {
  @override
  Widget build(BuildContext conte4xt) {
    return Scaffold(
      appBar: AppBar(
        title: Text("버그신고"),
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
