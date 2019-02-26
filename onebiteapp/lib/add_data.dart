import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:image_picker/image_picker.dart';

class AddPage extends StatefulWidget {

  @override
  AddPageState createState() {
    return new AddPageState();
  }
}

class AddPageState extends State<AddPage> {
  int calls = 0;
  String testimage = 'https://firebasestorage.googleapis.com/v0/b/onebite-cdaee.appspot.com/o/logo%2Flogotest.png?alt=media&token=3f01fd53-fbfe-4017-a8a6-98b6278e43c4';
  String name;
  String closed;
  String deliveryFee;
  String minimumOrder;
  String phone;
  String rate;
  String time;
  String type;

  //menu prices
  String price1;
  // String price2;
  // String price3;
  // String price4;
  // String price5;
  // String price6;

  //menu names
  String menu1;
  // String menu2;
  // String menu3;
  // String menu4;
  // String menu5;
  // String menu6;

  //top menu names
  String topmenu1;
  // String topmenu2;
  // String topmenu3;
  // String topmenu4;
  // String topmenu5;
  // String topmenu6;

  //top menu price
  String topprice1;
  // String topprice2;
  // String topprice3;
  // String topprice4;
  // String topprice5;
  // String topprice6;

  // String menu;
  final formKey = GlobalKey<FormState>();
  
  File sampleImage;
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
        title: Text('업체 등록'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.save,
            ),
            onPressed: () async {
              final wordPair = WordPair.random();
              final form = formKey.currentState;
              form.save();
              if(sampleImage !=  null ){
                  final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('${name}').child('${name}_${wordPair}.jpg');
                  // final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('bug-${wordPair}.jpg');
                  final StorageUploadTask uploadTask = firebaseStorageRef.putFile(sampleImage);
                  StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
                  var url = await storageTaskSnapshot.ref.getDownloadURL();
                  addURL = url.toString();
                  print('@@@@@@@@@@@@@@@@@@@@@@@');
                  print(addURL);
                }
              Firestore.instance.collection('restaurant').document(wordPair.toString())
              .setData(({
                'name' : '${this.name}',
                'closed' : '${this.closed}',
                'delivery fee': '${this.deliveryFee}',
                'minimum order': '${this.minimumOrder}',
                'type' : '${this.type}',
                'phone' : '${this.phone}',
                'rate' : '${this.rate}',
                'time' : '${this.time}',
                'logo' : '${this.testimage}',
                'calls' : this.calls,
                }));
              Firestore.instance.collection('restaurant').document(wordPair.toString()).collection('menu').document('${this.menu1}')
              .setData(({
                'name' : '${this.menu1}',
                'price' : '${this.price1}',
                }));
                Firestore.instance.collection('restaurant').document(wordPair.toString()).collection('topmenu').document('${this.topmenu1}')
              .setData(({
                'name' : '${this.topmenu1}',
                'price' : '${this.topprice1}',
                'image' : addURL,
                }));
                this.testimage = addURL;
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog (
                        content: Text('등록되었습니다!'),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('확인'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      );
                  }
                );
              Navigator.of(context).pop();
            },
          )
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Form(
                      key: formKey,
                        child: Column(
                      children: <Widget>[
                        TextFormField(
                            decoration: InputDecoration(
                              labelText: 'name : 달인의 찜닭',
                            ),
                            onSaved: (String str) {
                              this.name = str;
                            }),
                        TextFormField(
                            decoration: InputDecoration(
                              labelText: 'closed : 첫째, 셋째 주 월요일',
                            ),
                            onSaved: (String str) {
                              this.closed = str;
                            }),
                            TextFormField(
                            decoration: InputDecoration(
                              labelText: 'delivery fee : 2,000',
                            ),
                            onSaved: (String str) {
                              this.deliveryFee = str;
                            }),
                             TextFormField(
                            decoration: InputDecoration(
                              labelText: 'phone : 054-234-9344',
                            ),
                            onSaved: (String str) {
                              this.phone = str;
                            }),
                             TextFormField(
                            decoration: InputDecoration(
                              labelText: 'rate : 4.5',
                            ),
                            onSaved: (String str) {
                              this.rate = str;
                            }),
                             TextFormField(
                            decoration: InputDecoration(
                              labelText: 'time : 17:00 ~ 22:00',
                            ),
                            onSaved: (String str) {
                              this.time = str;
                            }),
                            TextFormField(
                            decoration: InputDecoration(
                              labelText: 'minimum order : 15,000',
                            ),
                            onSaved: (String str) {
                              this.minimumOrder = str;
                            }),
                            TextFormField(
                            decoration: InputDecoration(
                              labelText: 'type : fastfood, korean, chinese, japanese, boonsick',
                            ),
                            onSaved: (String str) {
                              this.type = str;
                            }),
                            TextFormField(
                            decoration: InputDecoration(
                              labelText: 'TOP menu1 : 허브순살치킨',
                            ),
                            onSaved: (String str) {
                              this.topmenu1 = str;
                            }),
                            TextFormField(
                            decoration: InputDecoration(
                              labelText: 'TOP price1 : 15,000',
                            ),
                            onSaved: (String str) {
                              this.topprice1 = str;
                            }),
                            sampleImage == null ? Image.network('${testimage}', height: 0.0, width: 0.0,) : Image.file(sampleImage, height : 250.0, width : 300.0),
                            SizedBox(height: 16.0,),
                            IconButton(
                              padding: EdgeInsets.fromLTRB(350, 0, 0, 0),
                              icon: Icon(Icons.photo_camera),
                              onPressed: () {
                                getImage();
                               },
                            ),
                            TextFormField(
                            decoration: InputDecoration(
                              labelText: 'menu1 : 양념 치킨',
                            ),
                            onSaved: (String str) {
                              this.menu1 = str;
                            }),
                            TextFormField(
                            decoration: InputDecoration(
                              labelText: 'menu price1 : 15,000',
                            ),
                            onSaved: (String str) {
                              this.price1 = str;
                            }),
                      ],
                    )),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}