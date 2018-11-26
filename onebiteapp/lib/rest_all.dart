// 전체식당
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

class _RestAllPageState extends State<RestAllPage> {
  final FirebaseUser user;
  _RestAllPageState({Key key, this.user});

  List<Restaurant> korean = new List<Restaurant>();
  List<Restaurant> chinese = new List<Restaurant>();
  List<Restaurant> japanese = new List<Restaurant>();
  List<Restaurant> boonSick = new List<Restaurant>();
  List<Restaurant> fastFood = new List<Restaurant>();



  Future _buildList() async {
    print("buildlist in");
    QuerySnapshot querySnapshot = await Firestore.instance.collection(
        "restaurants").getDocuments();
    var list = querySnapshot.documents;
    print(list.length);
    for (var i = 0; i < list.length; i++) {
      final Restaurant restaurant = Restaurant.fromSnapshot(list[i]);
      print(restaurant.name);
      setState(() {
        if (restaurant.type == 'korean')
          korean.add(restaurant);
        else if (restaurant.type == 'chinese')
          chinese.add(restaurant);
        else if (restaurant.type == 'japanese')
          japanese.add(restaurant);
        else if (restaurant.type == 'bookSick')
          boonSick.add(restaurant);
        else if (restaurant.type == 'fastFood') fastFood.add(restaurant);
      });

    }
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("init state yes");
    _buildList();

    print("init state over");

  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(fontFamily: 'NotoSans', primaryColor: Color.fromRGBO(255, 112, 74, 1)),
        home : DefaultTabController(
          length: 5,
          child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(text: '패스트푸드'),
                  Tab(text: '한식'),
                  Tab(text: '중식'),
                  Tab(text: '일식'),
                  Tab(text: '분식'),
                ],
              ),
              title: Text('전체 식당'),
            ),
            body: TabBarView(
              children: <Widget>[

                ListView.builder(
                    itemCount: fastFood.length,
                    itemBuilder: (context, index){
                      return ListTile(
                        title: Text(fastFood[index].name),
                        subtitle: Text("영업시간: " + fastFood[index].time),

                      );
                    }

                ),
                ListView.builder(
                    itemCount: korean.length,
                    itemBuilder: (context, index){
                      return ListTile(
                        title: Text(korean[index].name),
                        subtitle: Text("영업시간: " + korean[index].time),
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => DetailPage(user:user, restaurant: korean[index])))
                              .catchError((e) => print(e));
                        }

                      );

                    }

                ),
                ListView.builder(
                    itemCount: chinese.length,
                    itemBuilder: (context, index){
                      return ListTile(
                        title: Text(chinese[index].name),
                        subtitle: Text("영업시간: " + chinese[index].time),

                      );
                    }

                ),
                ListView.builder(
                    itemCount: japanese.length,
                    itemBuilder: (context, index){
                      return ListTile(
                        title: Text(japanese[index].name),
                        subtitle: Text("영업시간: " + japanese[index].time),

                      );
                    }
                ),
                ListView.builder(
                    itemCount: boonSick.length,
                    itemBuilder: (context, index){
                      return ListTile(
                        title: Text(boonSick[index].name),
                        subtitle: Text("영업시간: " + boonSick[index].time),

                      );
                    }

                ),

              ],
            ),
          ),
        )
    );
  }
}





class Restaurant {
  final String closed;
  final String deliveryFee;
  final String minimumOrder;
  final String name;
  final DocumentReference reference;
  final String phone;
  final String rate;
  final String time;
  final String type;
  Restaurant(this.closed, this.deliveryFee, this.minimumOrder, this.name, this.reference, this.phone, this.rate, this.time, this.type);

  Restaurant.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['closed'] != null),
        assert(map['delivery fee'] != null),
        assert(map['minimum order'] != null),
        assert(map['name'] != null),
        assert(map['phone'] != null),
        assert(map['rate'] != null),
        assert(map['time'] != null),
        assert(map['type'] != null),
        closed = map['closed'],
        deliveryFee = map['delivery fee'],
        minimumOrder = map['minimum order'],
        name = map['name'],
        phone = map['phone'],
        rate = map['rate'],
        time = map['time'],
        type = map['type'];


  Restaurant.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);


}