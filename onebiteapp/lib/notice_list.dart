// 공지사항 리스트업
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'notice_detail.dart';

class NoticeListPage extends StatefulWidget {
  @override
  _NoticeListPageState createState() => _NoticeListPageState();
}

class _NoticeListPageState extends State<NoticeListPage> {
  @override
  Future _data;

  Future getPosts() async {
    // instantiate my cloud firestore first
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("notice").getDocuments();
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
        title: Text("공지사항"),
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
                  // 추가할 부분 : DB에서 가장 최근에 추가된 내용이 top으로 오도록 sorting
                  itemCount: snapshot.data.length, // actual length of returned data from future
                  itemBuilder: (_, index) {
                    return ListTile(
                      title: Text(snapshot.data[index].data["title"]),
                      subtitle: Text(snapshot.data[index].data["date"]),
                      onTap: () => navigateToDetail(snapshot.data[index]),
                    );
                  },
                );
              }
            }),
      ),
    );
  }
}