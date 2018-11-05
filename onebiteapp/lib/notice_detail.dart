// 공지사항 디테일
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NoticeDetailPage extends StatefulWidget {
  final DocumentSnapshot post;

  NoticeDetailPage({this.post});

  @override
  _NoticeDetailPageState createState() => _NoticeDetailPageState();
}

class _NoticeDetailPageState extends State<NoticeDetailPage> {
  @override
  Widget build(BuildContext conte4xt) {
    return Scaffold(
      appBar: AppBar(
        title: Text("공지사항"),
      ),
      body: Container(
        // 여기는 display 틀만 잡으면 끝!
          child: ListTile(
            title: Text(widget.post.data["title"]),
            subtitle: Text(widget.post.data["content"]),
          ),
      ),
    );
  }
}
