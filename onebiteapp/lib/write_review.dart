import 'dart:io';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'rest_all.dart';
import 'rest_detail.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class WriteReviewPage extends StatefulWidget {
  final FirebaseUser user;
  final Restaurant restaurant;
  WriteReviewPage({Key key, this.user, this.restaurant});
  @override
  _WriteReviewPageState createState() => new _WriteReviewPageState(user: this.user, restaurant: this.restaurant);

}

class _WriteReviewPageState extends State<WriteReviewPage> {
  final FirebaseUser user;
  final Restaurant restaurant;
  TextStyle _categoryStyle = TextStyle(fontWeight: FontWeight.w800, fontSize: 17.0, color: Colors.black87);

  _WriteReviewPageState({Key key, this.user, this.restaurant});

  File galleryFile;
  Firestore store = Firestore.instance;
//save the result of camera file
  File cameraFile;
  final TextEditingController _nameControl = new TextEditingController();
  final TextEditingController _reviewControl = new TextEditingController();
  var rating = 0.0;
  String _name = '';
  String _review = '';
  String _path = '';
  final FirebaseStorage storage = FirebaseStorage(storageBucket: 'gs://onebite-cdaee.appspot.com');
  File sampleImage;

  String defaultURL = 'https://firebasestorage.googleapis.com/v0/b/onebite-cdaee.appspot.com/o/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA%202019-02-09%20%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE%208.36.33.png?alt=media&token=7d53ad80-5d86-4911-a5fc-72f8e014f67c';
  String addURL = '';
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
              // review close button
              // navigator pop..
              // 현재는 리뷰 작성하려다가 x 누르면 아예 메뉴까지 뒤로 가버리는 상황임.
              onPressed: (){
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (BuildContext context) => DetailPage(user:user, restaurant: restaurant, previous: "review")))
                //     .catchError((e) => print(e));     
                Navigator.pop(context);
              },
              icon: Icon(Icons.close, color: Theme.of(context).primaryColor),
            ),
          ),
          title: Text(restaurant.name, style: TextStyle(color: Colors.black)),
          actions: <Widget>[
            FlatButton(
              onPressed: () async {
                final wordPair = WordPair.random();
                if(sampleImage !=  null ){
                  // final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('myimage.jpg');
                  final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('review').child('review-${wordPair}.jpg');
                  final StorageUploadTask uploadTask = firebaseStorageRef.putFile(sampleImage);
                  StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
                  var url = await storageTaskSnapshot.ref.getDownloadURL();
                  addURL = url.toString();
                  print('@@@@@@@@@@@@@@@@@@@@@@@');
                  print(addURL);
                  // _path = url.toString();
                  // print(_path);
                }
                // final wordPair = WordPair.random();
                var now = DateTime.now();
                String createTime = now.year.toString() + '.' + now.month.toString() + '.' + now.day.toString();
                store.runTransaction((transaction) async {
                  // restaurant - review collection 생성 시, user.uid로 하자
                  // user - review 생성해서 자기가만든 리뷰들은 따로 보거나 삭제할수있게 해주자 (v1.5)
                  store.collection("restaurant").document(restaurant.reference.documentID).collection("review").document(wordPair.toString())
                  .setData({
                    "author": _name,
                    "rate": rating.toString(),
                    "context": _review,
                    "date": createTime,
                    "uid": user.uid,
                    "image" : addURL,
                    });
                    this.defaultURL = addURL;
                });
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => DetailPage(user:user, restaurant: restaurant, previous: "review")))
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
                SizedBox(
                    height: 30.0,
                    width: 80.0,

                    child: Text("별점", style: _categoryStyle)

                ),
                SmoothStarRating(
                  allowHalfRating: true,
                  onRatingChanged: (v) {
                    rating = v - v%.5;
                    setState(() {});
                  },
                  starCount: 5,
                  rating: rating,
                  size: 30.0,
                  color: Theme.of(context).primaryColor,
                  borderColor: Color.fromRGBO(255, 218, 77, 1),
                )
              ],
            ),
            SizedBox(height:10.0),
            Row(
              children: <Widget>[
                SizedBox(
                    height: 30.0,
                    width: 80.0,

                    child: Text("닉네임", style: _categoryStyle)

                ),
                SizedBox(
                    width: 200.0,
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '닉네임을 입력하세요.',
                      ),
                      enabled:true,
                      controller: _nameControl,
                      onChanged: (String e){
                        setState(() {
                          _name = e;
                        });
                      },

                    )
                )
              ],
            ),

            // 리뷰 작성 박스
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
            
            SizedBox(height: 20.0,),

            // 사진 업로드하면 그 사진 보여주는 칸
            sampleImage == null ? Image.network('${defaultURL}', height: 0.0, width: 0.0,) : Image.file(sampleImage, height : 250.0, width : 300.0),

            // 카메라 버튼
            Container(
                height: 100.0,
                child: Row(
                  children: <Widget>[
                    FlatButton(
                        color: Color.fromRGBO(230, 230, 230, 1),
                        child: Icon(Icons.camera_alt, color: Colors.white),
                        onPressed: (){
                          getImage();
                        }
                    )
                  ],
                )
            ),

          ],
        )
    );

  }
}
