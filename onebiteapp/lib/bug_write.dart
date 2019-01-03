
import 'dart:io';
import 'package:Shrine/bug_report.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class WriteBugPage extends StatefulWidget {
  final FirebaseUser user;
  WriteBugPage({Key key, this.user});
  @override
  _WriteBugPageState createState() => new _WriteBugPageState(user: this.user);

}

class _WriteBugPageState extends State<WriteBugPage> {
  final FirebaseUser user;
  TextStyle _categoryStyle = TextStyle(fontWeight: FontWeight.w800, fontSize: 17.0, color: Colors.black87);

  _WriteBugPageState({Key key, this.user,});

  // File galleryFile;
  Firestore store = Firestore.instance;
  //save the result of camera file
  // File cameraFile;
  final TextEditingController _titleControl = new TextEditingController();
  // final TextEditingController _nameControl = new TextEditingController();
  final TextEditingController _reviewControl = new TextEditingController();
  String _title = '';
  // String _name = '';
  String _review = '';
  String defaultURL = 'https://firebasestorage.googleapis.com/v0/b/onebite-cdaee.appspot.com/o/logo%2Flogotest.png?alt=media&token=3f01fd53-fbfe-4017-a8a6-98b6278e43c4';
  String addURL = '';
  // String _path = '';
  // final FirebaseStorage storage = FirebaseStorage(storageBucket: 'gs://onebite-cdaee.appspot.com');
  File sampleImage;

  Future getImage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      sampleImage = tempImage;
    });
  }
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: ButtonTheme(
            minWidth: 100.0,
            child: IconButton(
                // cloase button
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(Icons.close, color: Theme.of(context).primaryColor),
            ),
          ),
          title: Text('버그신고', style: TextStyle(color: Colors.black)),
          actions: <Widget>[
            FlatButton(
              onPressed: () async {
                final wordPair = WordPair.random();

                if(sampleImage !=  null ){
                  final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('bug-${wordPair}.jpg');
                  final StorageUploadTask uploadTask = firebaseStorageRef.putFile(sampleImage);
                  StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
                  var url = await storageTaskSnapshot.ref.getDownloadURL();
                  addURL = url.toString();
                  print('@@@@@@@@@@@@@@@@@@@@@@@');
                  print(addURL);
                }

                var now = DateTime.now();
                String createTime = now.year.toString() + '.' + now.month.toString() + '.' + now.day.toString();
                store.runTransaction((transaction) async {
                  // restaurant - review collection 생성 시, user.uid로 하자
                  // user - review 생성해서 자기가만든 리뷰들은 따로 보거나 삭제할수있게 해주자 (v1.5)
                  store.collection("bug").document(wordPair.toString())
                  .setData({
                    "writer" : this.user.displayName,
                    "title" : _title,
                    "content": _review,
                    "date": createTime,
                    "uid": user.uid,
                    "image" : addURL,
                    });
                    this.defaultURL = addURL;
                });
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => BugReportPage(user:user )))
                    .catchError((e) => print(e));
              },

              child: Text("완료", style: TextStyle(color: Theme.of(context).primaryColor)),
            ),
          ],
        ),
        body: ListView(
          padding: EdgeInsets.all(20.0),
          children: <Widget>[
            Row(
              children: <Widget>[
                // 별점 대신 버그신고 title
                SizedBox(
                    height: 30.0,
                    width: 80.0,

                    child: Text("제목", style: _categoryStyle)

                ),
                SizedBox(
                    width: 200.0,
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '제목을 입력하세요.',
                      ),
                      enabled:true,
                      controller: _titleControl,
                      onChanged: (String e){
                        setState(() {
                          _title = e;
                        });
                      },
                    )
                )
              ],
            ),
            SizedBox(height:10.0),
            //사진
            sampleImage == null ? Image.network('${defaultURL}') : Image.file(sampleImage, height : 250.0, width : 300.0),
            SizedBox(height: 16.0,),
            IconButton(
              padding: EdgeInsets.fromLTRB(350, 0, 0, 0),
              icon: Icon(Icons.photo_camera),
              onPressed: () {
                getImage();
              },
            ),

            SizedBox(height: 20.0,),
            SizedBox(
                width: 200.0,
                height: 140.0,
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 6,
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                    ),
                    hintText: '소중한 의견을 남겨주셔서 감사합니다.',
                  ),
                  enabled:true,
                  controller: _reviewControl,
                  onChanged: (String e){
                    setState(() {
                      _review = e;
                    });
                  },

                )
            ),
          ],
        )
    );

  }
}
