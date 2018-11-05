// 공지사항 리스트업

import 'package:flutter/material.dart';

class NoticeListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Basic List';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              // leading: Icon(Icons.map),
              title: Text('[공지] 한입만 업데이트 안내'),
              subtitle: Text('2018.11.9'),
            ),
            ListTile(
              // leading: Icon(Icons.photo_album),
              title: Text('[공지] 한입만 업데이트 안내'),
              subtitle: Text('2018.10.13'),
            ),
            ListTile(
              // leading: Icon(Icons.phone),
              title: Text('[공지] 한입만 업데이트 안내'),
              subtitle: Text('2018.9.8'),
            ),
          ],
        ),
      ),
    );
  }
}