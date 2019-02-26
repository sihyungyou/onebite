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

  bool isaddtopmenu1 = false;
  bool isaddtopmenu2 = false;
  bool isaddtopmenu3 = false;
  bool isaddtopmenu4 = false;
  bool isaddtopmenu5 = false;
  bool isaddtopmenu6 = false;

  //top menu names
  String topmenu1;
  String topmenu2;
  String topmenu3;
  String topmenu4;
  String topmenu5;
  String topmenu6;

  //top menu price
  String topprice1;
  String topprice2;
  String topprice3;
  String topprice4;
  String topprice5;
  String topprice6;

  // String menu;
  final formKey = GlobalKey<FormState>();
  
  // File sampleImage;
  File sampleImage1;
  File sampleImage2;
  File sampleImage3;
  File sampleImage4;
  File sampleImage5;
  File sampleImage6;


  String topmenuurl1 = '';
  String topmenuurl2 = '';
  String topmenuurl3 = '';
  String topmenuurl4 = '';
  String topmenuurl5 = '';
  String topmenuurl6 = '';

//   Future getImage() async {
//   var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);

//   setState(() {
//     sampleImage = tempImage;
//   });
// }
  Future getImage1() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      sampleImage1 = tempImage;
    });
  }
  
  Future getImage2() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      sampleImage2 = tempImage;
    });
  }

  Future getImage3() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      sampleImage3 = tempImage;
    });
  }

    Future getImage4() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      sampleImage4 = tempImage;
    });
  }

    Future getImage5() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      sampleImage5 = tempImage;
    });
  }

    Future getImage6() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      sampleImage6 = tempImage;
    });
  }

  List<DropdownMenuItem<String>> _dropDownItem() {
    List<String> types = [
      "fastfood",
      "korean",
      "chinese",
      "japanese",
      "boonsick",
    ];
    return types.map(
      (value) => DropdownMenuItem(
        value : value,
        child: Text(value),
      )
    ).toList();
  }

  Widget addtopmenu1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
        decoration: InputDecoration(
          labelText: 'TOP menu 1 : 허브순살치킨',
        ),
        onSaved: (String str) {
          this.topmenu1 = str;
        }),
        TextFormField(
        decoration: InputDecoration(
          labelText: 'TOP price 1 : 15,000',
        ),
        onSaved: (String str) {
          this.topprice1 = str;
        }),
        // sampleImage == null ? Image.network('${testimage}', height: 0.0, width: 0.0,) : Image.file(sampleImage, height : 250.0, width : 250.0),
        sampleImage1 == null ? Image.network('${testimage}', height: 0.0, width: 0.0,) : Image.file(sampleImage1, height : 250.0, width : 250.0),
        Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.photo_camera),
              onPressed: () {
                getImage1();
              },
            ),
            IconButton(
              icon: Icon(Icons.remove_circle),
              onPressed: () {
                setState(() {
                  isaddtopmenu1 = false;
                });
              },
            ),
          ],
        ),
        IconButton(
        icon: Icon(Icons.add_circle),
        onPressed: () {
          setState(() {
            isaddtopmenu2 = true;
          });
        },
      ),
      ],
    );
  }

  Widget addtopmenu2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
        decoration: InputDecoration(
          labelText: 'TOP menu 2 : 허브순살치킨',
        ),
        onSaved: (String str) {
          this.topmenu2 = str;
        }),
        TextFormField(
        decoration: InputDecoration(
          labelText: 'TOP price 2 : 15,000',
        ),
        onSaved: (String str) {
          this.topprice2 = str;
        }),
        // sampleImage == null ? Image.network('${testimage}', height: 0.0, width: 0.0,) : Image.file(sampleImage, height : 250.0, width : 250.0),
        sampleImage2 == null ? Image.network('${testimage}', height: 0.0, width: 0.0,) : Image.file(sampleImage2, height : 250.0, width : 250.0),
        Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.photo_camera),
              onPressed: () {
                getImage2();
              },
            ),
            IconButton(
              icon: Icon(Icons.remove_circle),
              onPressed: () {
                setState(() {
                  isaddtopmenu2 = false;
                });
              },
            ),
          ],
        ),
        IconButton(
        icon: Icon(Icons.add_circle),
        onPressed: () {
          setState(() {
            isaddtopmenu3 = true;
          });
        },
      ),
      ],
    );
  }

  Widget addtopmenu3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
        decoration: InputDecoration(
          labelText: 'TOP menu 3 : 허브순살치킨',
        ),
        onSaved: (String str) {
          this.topmenu3 = str;
        }),
        TextFormField(
        decoration: InputDecoration(
          labelText: 'TOP price 3 : 15,000',
        ),
        onSaved: (String str) {
          this.topprice3 = str;
        }),
        sampleImage3 == null ? Image.network('${testimage}', height: 0.0, width: 0.0,) : Image.file(sampleImage3, height : 250.0, width : 250.0),
        Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.photo_camera),
              onPressed: () {
                getImage3();
              },
            ),
            IconButton(
              icon: Icon(Icons.remove_circle),
              onPressed: () {
                setState(() {
                  isaddtopmenu3 = false;
                });
              },
            ),
          ],
        ),
        IconButton(
        icon: Icon(Icons.add_circle),
        onPressed: () {
          setState(() {
            isaddtopmenu4 = true;
          });
        },
      ),
      ],
    );
  }

  Widget addtopmenu4() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
        decoration: InputDecoration(
          labelText: 'TOP menu 4 : 허브순살치킨',
        ),
        onSaved: (String str) {
          this.topmenu4 = str;
        }),
        TextFormField(
        decoration: InputDecoration(
          labelText: 'TOP price 4 : 15,000',
        ),
        onSaved: (String str) {
          this.topprice4 = str;
        }),
        sampleImage4 == null ? Image.network('${testimage}', height: 0.0, width: 0.0,) : Image.file(sampleImage4, height : 250.0, width : 250.0),
        Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.photo_camera),
              onPressed: () {
                getImage4();
              },
            ),
            IconButton(
              icon: Icon(Icons.remove_circle),
              onPressed: () {
                setState(() {
                  isaddtopmenu4 = false;
                });
              },
            ),
          ],
        ),
        IconButton(
        icon: Icon(Icons.add_circle),
        onPressed: () {
          setState(() {
            isaddtopmenu5 = true;
          });
        },
      ),
      ],
    );
  }

  Widget addtopmenu5() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
        decoration: InputDecoration(
          labelText: 'TOP menu 5 : 허브순살치킨',
        ),
        onSaved: (String str) {
          this.topmenu5 = str;
        }),
        TextFormField(
        decoration: InputDecoration(
          labelText: 'TOP price 5 : 15,000',
        ),
        onSaved: (String str) {
          this.topprice5 = str;
        }),
        sampleImage5 == null ? Image.network('${testimage}', height: 0.0, width: 0.0,) : Image.file(sampleImage5, height : 250.0, width : 250.0),
        Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.photo_camera),
              onPressed: () {
                getImage5();
              },
            ),
            IconButton(
              icon: Icon(Icons.remove_circle),
              onPressed: () {
                setState(() {
                  isaddtopmenu5 = false;
                });
              },
            ),
          ],
        ),
        IconButton(
        icon: Icon(Icons.add_circle),
        onPressed: () {
          setState(() {
            isaddtopmenu6 = true;
          });
        },
      ),
      ],
    );
  }

  Widget addtopmenu6() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
        decoration: InputDecoration(
          labelText: 'TOP menu 6 : 허브순살치킨',
        ),
        onSaved: (String str) {
          this.topmenu6 = str;
        }),
        TextFormField(
        decoration: InputDecoration(
          labelText: 'TOP price 6 : 15,000',
        ),
        onSaved: (String str) {
          this.topprice6 = str;
        }),
        sampleImage6 == null ? Image.network('${testimage}', height: 0.0, width: 0.0,) : Image.file(sampleImage6, height : 250.0, width : 250.0),
        Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.photo_camera),
              onPressed: () {
                getImage6();
              },
            ),
            IconButton(
              icon: Icon(Icons.remove_circle),
              onPressed: () {
                setState(() {
                  isaddtopmenu6 = false;
                });
              },
            ),
          ],
        ),
      ],
    );
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
              // if(sampleImage !=  null ){
              //     final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('${name}').child('${name}_${wordPair}.jpg');
              //     // final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('bug-${wordPair}.jpg');
              //     final StorageUploadTask uploadTask = firebaseStorageRef.putFile(sampleImage);
              //     StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
              //     var url = await storageTaskSnapshot.ref.getDownloadURL();
              //     addURL = url.toString();
              //     print('@@@@@@@@@@@@@@@@@@@@@@@');
              //     print(addURL);
              //   }
              if(sampleImage1 !=  null ){
                  final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('${name}').child('${name}_${topmenu1}.jpg');
                  // final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('bug-${wordPair}.jpg');
                  final StorageUploadTask uploadTask = firebaseStorageRef.putFile(sampleImage1);
                  StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
                  var url = await storageTaskSnapshot.ref.getDownloadURL();
                  topmenuurl1 = url.toString();
                }
              if(sampleImage2 !=  null ){
                  final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('${name}').child('${name}_${topmenu2}.jpg');
                  // final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('bug-${wordPair}.jpg');
                  final StorageUploadTask uploadTask = firebaseStorageRef.putFile(sampleImage2);
                  StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
                  var url = await storageTaskSnapshot.ref.getDownloadURL();
                  topmenuurl2 = url.toString();
                }
              if(sampleImage3 !=  null ){
                  final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('${name}').child('${name}_${topmenu3}.jpg');
                  // final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('bug-${wordPair}.jpg');
                  final StorageUploadTask uploadTask = firebaseStorageRef.putFile(sampleImage3);
                  StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
                  var url = await storageTaskSnapshot.ref.getDownloadURL();
                  topmenuurl3 = url.toString();
                }
              if(sampleImage4 !=  null ){
                  final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('${name}').child('${name}_${topmenu4}.jpg');
                  // final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('bug-${wordPair}.jpg');
                  final StorageUploadTask uploadTask = firebaseStorageRef.putFile(sampleImage4);
                  StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
                  var url = await storageTaskSnapshot.ref.getDownloadURL();
                  topmenuurl4 = url.toString();
                }
              if(sampleImage5 !=  null ){
                  final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('${name}').child('${name}_${topmenu5}.jpg');
                  // final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('bug-${wordPair}.jpg');
                  final StorageUploadTask uploadTask = firebaseStorageRef.putFile(sampleImage5);
                  StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
                  var url = await storageTaskSnapshot.ref.getDownloadURL();
                  topmenuurl5 = url.toString();
                }
              if(sampleImage6 !=  null ){
                  final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('${name}').child('${name}_${topmenu6}.jpg');
                  // final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('bug-${wordPair}.jpg');
                  final StorageUploadTask uploadTask = firebaseStorageRef.putFile(sampleImage6);
                  StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
                  var url = await storageTaskSnapshot.ref.getDownloadURL();
                  topmenuurl6 = url.toString();
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
                'image' : topmenuurl1,
                }));
                this.testimage = topmenuurl1;

              Firestore.instance.collection('restaurant').document(wordPair.toString()).collection('topmenu').document('${this.topmenu2}')
              .setData(({
                'name' : '${this.topmenu2}',
                'price' : '${this.topprice2}',
                'image' : topmenuurl2,
                }));
                this.testimage = topmenuurl2;

              Firestore.instance.collection('restaurant').document(wordPair.toString()).collection('topmenu').document('${this.topmenu3}')
              .setData(({
                'name' : '${this.topmenu3}',
                'price' : '${this.topprice3}',
                'image' : topmenuurl3,
                }));
                this.testimage = topmenuurl3;

              Firestore.instance.collection('restaurant').document(wordPair.toString()).collection('topmenu').document('${this.topmenu4}')
              .setData(({
                'name' : '${this.topmenu4}',
                'price' : '${this.topprice4}',
                'image' : topmenuurl4,
                }));
                this.testimage = topmenuurl4;

              Firestore.instance.collection('restaurant').document(wordPair.toString()).collection('topmenu').document('${this.topmenu5}')
              .setData(({
                'name' : '${this.topmenu5}',
                'price' : '${this.topprice5}',
                'image' : topmenuurl5,
                }));
                this.testimage = topmenuurl5;

              Firestore.instance.collection('restaurant').document(wordPair.toString()).collection('topmenu').document('${this.topmenu6}')
              .setData(({
                'name' : '${this.topmenu6}',
                'price' : '${this.topprice6}',
                'image' : topmenuurl6,
                }));
                this.testimage = topmenuurl6;


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
                          crossAxisAlignment: CrossAxisAlignment.start,
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


                            // TextFormField(
                            // decoration: InputDecoration(
                            //   labelText: 'type : fastfood, korean, chinese, japanese, boonsick',
                            // ),
                            // onSaved: (String str) {
                            //   this.type = str;
                            // }),
                            DropdownButton(
                              value: type,
                              items: _dropDownItem(),
                              onChanged: (value) {
                                this.type = value;
                                setState(() {});
                              },
                              hint: Text('select types'),
                            ),

                            IconButton(
                              icon: Icon(Icons.add_circle),
                              onPressed: () {
                                setState(() {
                                  isaddtopmenu1 = true;
                                  isaddtopmenu1 = true;
                                });
                                print('탑 메뉴 추가');
                              },
                            ),
                            isaddtopmenu1 == true ? addtopmenu1() : Text(""),
                            isaddtopmenu2 == true ? addtopmenu2() : Text(""),
                            isaddtopmenu3 == true ? addtopmenu3() : Text(""),
                            isaddtopmenu4 == true ? addtopmenu4() : Text(""),
                            isaddtopmenu5 == true ? addtopmenu5() : Text(""),
                            isaddtopmenu6 == true ? addtopmenu6() : Text(""),

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