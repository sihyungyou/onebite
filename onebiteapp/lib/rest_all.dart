// 전체식당
// search
// tab controller 내리기 -> ok
// reload 문제 해결 -> ok
// 사진 == logo (원 안에)
// 배달비 여부 아이콘
// favorite 여부 아이콘
// future builder -> ok

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'rest_detail.dart';


class RestAllPage extends StatefulWidget {
  @override
  final FirebaseUser user;
  RestAllPage({Key key, this.user});
  _RestAllPageState createState() => _RestAllPageState(user: user);
}

class _RestAllPageState extends State<RestAllPage> with SingleTickerProviderStateMixin {
  TextStyle _tabTitleStyle = TextStyle(fontWeight: FontWeight.w600, fontSize: 20.0, color: Colors.black87);
  TextStyle _titleStyle = TextStyle(fontWeight: FontWeight.w600, fontSize: 15.0);
  TabController _controller;
  Future _data;
  final FirebaseUser user;
  _RestAllPageState({Key key, this.user});

  // List<Restaurant> korean = new List<Restaurant>();
  // List<Restaurant> chinese = new List<Restaurant>();
  // List<Restaurant> japanese = new List<Restaurant>();
  // List<Restaurant> boonSick = new List<Restaurant>();
  // List<Restaurant> fastFood = new List<Restaurant>();


  // void _buildList() async {
  //   print("buildlist in");
  //   QuerySnapshot querySnapshot = await Firestore.instance.collection(
  //       "restaurants").getDocuments();
  //   var list = querySnapshot.documents;
  //   print(list.length);
  //   for (var i = 0; i < list.length; i++) {
  //     final Restaurant restaurant = Restaurant.fromSnapshot(list[i]);
  //     print(restaurant.name);
  //     if (restaurant.type == 'korean')
  //       korean.add(restaurant);
  //     else if (restaurant.type == 'chinese')
  //       chinese.add(restaurant);
  //     else if (restaurant.type == 'japanese')
  //       japanese.add(restaurant);
  //     else if (restaurant.type == 'bookSick')
  //       boonSick.add(restaurant);
  //     else if (restaurant.type == 'fastFood') fastFood.add(restaurant);
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   print("init state yes");
  //   _buildList();
  //   print("init state over");
  // }

  Future getPosts() async {
    print("getpost");
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("restaurant").getDocuments();
    return qn.documents;
  }
  @override
  void initState() {
    // future: getPosts() 로 하면 매번 notice detail 에서 돌아올 때에도 계속 execute함. 그걸 해결하기 위해서
    super.initState();
    _data = getPosts(); // now, instead of call getpost every time, the future can simply use _data! no more re-render
    _controller = new TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Text('전체 식당', 
          style: _titleStyle,
          ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/add');
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          new Container(
          child: new TabBar(
            controller: _controller,
            tabs: <Widget>[
              new Tab(
                child: Text('패스트푸드', 
                style: TextStyle( color: Colors.black,)
                ),
              ),
              new Tab(
                child: Text('한식',
                style: TextStyle( color: Colors.black,)),
              ),
              new Tab(
                child: Text('중식',
                style: TextStyle( color: Colors.black,)),
              ),
              new Tab(
                child: Text('일식',
                style: TextStyle( color: Colors.black,)),
              ),
              new Tab(
                child: Text('분식',
                style: TextStyle( color: Colors.black,)),
              ),
            ],
          ),
          ),
          new Container(
            height: 300.0,
            child: new TabBarView(
              controller: _controller,
              children: <Widget>[
                // 패스트푸드 tab
                FutureBuilder(
                  future: _data,
                  builder: (_, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child : Text('Loading...'),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (_, index) {
                          if (snapshot.data[index].data["type"] == "fastfood") {
                            return ListTile(
                              title: Text(snapshot.data[index].data["name"]),
                              subtitle: Text(snapshot.data[index].data["time"]),
                          );
                          }
                        },
                      );
                    }
                  },
                ),
                // 한식 tab
                FutureBuilder(
                  future: _data,
                  builder: (_, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child : Text('Loading...'),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (_, index) {
                          if (snapshot.data[index].data["type"] == "korean") {
                            return ListTile(
                              title: Text(snapshot.data[index].data["name"]),
                              subtitle: Text(snapshot.data[index].data["time"]),
                              onTap: () {
                                print('ontap test');
                                print(snapshot.data[index]);
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) => DetailPage(user:user, restaurant: snapshot.data[index]))).catchError((e) => print(e));}
                          );
                          }
                        },
                      );
                    }
                  },
                ),
                // 중식 tab
                FutureBuilder(
                  future: _data,
                  builder: (_, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child : Text('Loading...'),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (_, index) {
                          if (snapshot.data[index].data["type"] == "chinese") {
                            return ListTile(
                              title: Text(snapshot.data[index].data["name"]),
                              subtitle: Text(snapshot.data[index].data["time"]),
                              onTap: () {
                                print('ontap test');
                                print(snapshot.data[index]);
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) => DetailPage(user:user, restaurant: snapshot.data[index]))).catchError((e) => print(e));}
                          );
                          }
                        },
                      );
                    }
                  },
                ),
                // 일식 tab
                FutureBuilder(
                  future: _data,
                  builder: (_, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child : Text('Loading...'),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (_, index) {
                          if (snapshot.data[index].data["type"] == "japanese") {
                            return ListTile(
                              title: Text(snapshot.data[index].data["name"]),
                              subtitle: Text(snapshot.data[index].data["time"]),
                              onTap: () {
                                print('ontap test');
                                print(snapshot.data[index]);
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) => DetailPage(user:user, restaurant: snapshot.data[index]))).catchError((e) => print(e));}
                          );
                          }
                        },
                      );
                    }
                  },
                ),
                // 분식 tab
                FutureBuilder(
                  future: _data,
                  builder: (_, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child : Text('Loading...'),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (_, index) {
                          if (snapshot.data[index].data["type"] == "boonsik") {
                            return ListTile(
                              title: Text(snapshot.data[index].data["name"]),
                              subtitle: Text(snapshot.data[index].data["time"]),
                              onTap: () {
                                print('ontap test');
                                print(snapshot.data[index]);
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) => DetailPage(user:user, restaurant: snapshot.data[index]))).catchError((e) => print(e));}
                          );
                          }
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
  
  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //       theme: ThemeData(fontFamily: 'NotoSans', primaryColor: Color.fromRGBO(255, 112, 74, 1)),
  //       home : DefaultTabController(
  //         length: 5,
  //         child: Scaffold(
  //           appBar: AppBar(
  //             bottom: TabBar(
  //               tabs: <Widget>[
  //                 Tab(text: '패스트푸드'),
  //                 Tab(text: '한식'),
  //                 Tab(text: '중식'),
  //                 Tab(text: '일식'),
  //                 Tab(text: '분식'),
  //               ],
  //             ),
  //             title: Text('전체 식당'),
  //             actions: <Widget>[
  //               IconButton(
  //                 icon: Icon(Icons.add),
  //                 onPressed: () {
  //                   // go to add data
  //                   Navigator.pushNamed(context, '/add');
  //                 },
  //                 ),
  //             ],
  //           ),
  //           body: TabBarView(
  //             children: <Widget>[

  //               ListView.builder(
  //                   itemCount: fastFood.length,
  //                   itemBuilder: (context, index){
  //                     return ListTile(
  //                       title: Text(fastFood[index].name),
  //                       subtitle: Text("영업시간: " + fastFood[index].time),

  //                     );
  //                   }

  //               ),
  //               ListView.builder(
  //                   itemCount: korean.length,
  //                   itemBuilder: (context, index){
  //                     return ListTile(
  //                       title: Text(korean[index].name),
  //                       subtitle: Text("영업시간: " + korean[index].time),
  //                       onTap: (){
  //                         Navigator.of(context).push(MaterialPageRoute(
  //                             builder: (BuildContext context) => DetailPage(user:user, restaurant: korean[index])))
  //                             .catchError((e) => print(e));
  //                       }

  //                     );

  //                   }

  //               ),
  //               ListView.builder(
  //                   itemCount: chinese.length,
  //                   itemBuilder: (context, index){
  //                     return ListTile(
  //                       title: Text(chinese[index].name),
  //                       subtitle: Text("영업시간: " + chinese[index].time),

  //                     );
  //                   }

  //               ),
  //               ListView.builder(
  //                   itemCount: japanese.length,
  //                   itemBuilder: (context, index){
  //                     return ListTile(
  //                       title: Text(japanese[index].name),
  //                       subtitle: Text("영업시간: " + japanese[index].time),

  //                     );
  //                   }
  //               ),
  //               ListView.builder(
  //                   itemCount: boonSick.length,
  //                   itemBuilder: (context, index){
  //                     return ListTile(
  //                       title: Text(boonSick[index].name),
  //                       subtitle: Text("영업시간: " + boonSick[index].time),

  //                     );
  //                   }

  //               ),

  //             ],
  //           ),
  //         ),
  //       )
  //   );
  // }
}





// class Restaurant {
//   final String closed;
//   final String deliveryFee;
//   final String minimumOrder;
//   final String name;
//   final DocumentReference reference;
//   final String phone;
//   final String rate;
//   final String time;
//   final String type;
//   Restaurant(this.closed, this.deliveryFee, this.minimumOrder, this.name, this.reference, this.phone, this.rate, this.time, this.type);

//   Restaurant.fromMap(Map<String, dynamic> map, {this.reference})
//       : assert(map['closed'] != null),
//         assert(map['delivery fee'] != null),
//         assert(map['minimum order'] != null),
//         assert(map['name'] != null),
//         assert(map['phone'] != null),
//         assert(map['rate'] != null),
//         assert(map['time'] != null),
//         assert(map['type'] != null),
//         closed = map['closed'],
//         deliveryFee = map['delivery fee'],
//         minimumOrder = map['minimum order'],
//         name = map['name'],
//         phone = map['phone'],
//         rate = map['rate'],
//         time = map['time'],
//         type = map['type'];


//   Restaurant.fromSnapshot(DocumentSnapshot snapshot)
//       : this.fromMap(snapshot.data, reference: snapshot.reference);


// }
