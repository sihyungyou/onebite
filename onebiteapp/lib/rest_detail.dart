import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Shrine/rest_all.dart';

class DetailPage extends StatefulWidget {
  final FirebaseUser user;
  final Restaurant restaurant;
  // final DocumentSnapshot restaurant;
  DetailPage({Key key, this.user, this.restaurant});
  DetailPageState createState() => DetailPageState(user: this.user, restaurant: this.restaurant);
}

class DetailPageState extends State<DetailPage> with SingleTickerProviderStateMixin{
   final FirebaseUser user;
   final Restaurant restaurant;
  // final DocumentSnapshot restaurant;
   List<Menu> menu = List<Menu>();
   bool favorited = false;
   final Color onebiteButton = Color.fromRGBO(255, 112, 74, 1);

   TextStyle _titleStyle = TextStyle(fontWeight: FontWeight.w600, fontSize: 15.0);
   TextStyle _bodyStyle = TextStyle(fontWeight: FontWeight.w300, fontSize: 15.0);
   TextStyle _tabTitleStyle = TextStyle(fontWeight: FontWeight.w600, fontSize: 20.0, color: Colors.black87);

   TextStyle _orderButtonStyle = TextStyle(fontWeight: FontWeight.w600, fontSize: 20.0, color: Colors.white);
   DetailPageState({Key key, this.user, this.restaurant});

   void _buildList() async {
     QuerySnapshot querySnapshot = await Firestore.instance.collection("restaurants").document(restaurant.reference.documentID).collection('menu').getDocuments();
     var list = querySnapshot.documents;
     print(list.length);
     for (var i = 0; i < list.length; i++) {
       menu.add(Menu.fromSnapshot(list[i]));
       print(menu[i].name);
       print(menu[i].price);

     }
   }
   TabController _controller;

   @override
  void initState() {

    _buildList();
    _controller = new TabController(length: 2, vsync: this);

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: onebiteButton,
        child: FlatButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.call, color: Colors.white),
              Text("전화주문", style: _orderButtonStyle),
            ],
          ),
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => RestAllPage(user:user)))
                .catchError((e) => print(e));
          }
        )
      ),
      body: ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: onebiteButton),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Padding(
            padding : EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                Text(restaurant.name, textAlign: TextAlign.center, style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w800)),
                // Text(restaurant["name"], textAlign: TextAlign.center, style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w800)),
                SizedBox(height: 5.0),
                Text(restaurant.rate, textAlign: TextAlign.center, style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500)),
                // Text(restaurant["rate"], textAlign: TextAlign.center, style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500)),
                Container(
                  height: 35.0,
                  child:  Row(
                    children: <Widget>[
                      SizedBox(width : 280.0),
                      IconButton(
                          iconSize: 20.0,
                          icon: favorited ? Icon(Icons.favorite, color: Colors.red) : Icon(Icons.favorite_border, color: Colors.red),
                          onPressed: (){
                            setState(() {
                              favorited = !favorited;
                            });

                          }
                      ),

                    ],
                  ),
                ),
                Divider(),


                SizedBox(height: 5.0),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 100.0,
                      child: Text("배달시간", style: _titleStyle),
                    ),
                    Text(restaurant.time, style: _bodyStyle),
                    // Text(restaurant["time"], style: _bodyStyle),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 100.0,
                      child: Text("배달비", style: _titleStyle),
                    ),
                    Text(restaurant.deliveryFee + "원", style: _bodyStyle),
                    // Text('${restaurant["delivery fee"]}' + "원", style: _bodyStyle),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 100.0,
                      child: Text("최소주문금액", style: _titleStyle),
                    ),
                    Text(restaurant.minimumOrder + "원", style: _bodyStyle),
                    // Text('${restaurant["minimum order"]}' + "원", style: _bodyStyle),
                  ],
                ),
                SizedBox(height: 15.0),
              ],
            )
          ),

          Container(height: 15.0, color: onebiteButton),

          new Container(
            child: new TabBar(
              controller: _controller,
              tabs: [
                new Tab(
                  child: Text("메뉴", style: _tabTitleStyle),
                ),
                new Tab(
                  child: Text("정보", style: _tabTitleStyle),
                ),
                new Tab(
                  child: Text("리뷰", style: _tabTitleStyle),
                ),
              ],
            ),
          ),
          new Container(
            height: 300.0,
            child: new TabBarView(
              controller: _controller,
              children: <Widget>[

                // 메뉴
                // 여기 menu(collection) -> random id(document) -> name(field) 로 접근 해야 함.
                ListView.builder(
                    // itemCount: restaurant
                    itemBuilder: (context, index){
                      return ListTile(
                        // title: Text(menu[index].name),
                        // title: Text(restaurant["menu"].data["yZzR0SXi8UefIWb8ITzF"].data["name"]),
                        // subtitle: Text(menu[index].price + "원"),
                      );
                    }
                ),

                // 영업 정보
                ListView(
                  padding : EdgeInsets.symmetric(horizontal: 20.0),
                  children: <Widget>[
                    SizedBox(height: 30.0),
                    Text("영업정보", style: _tabTitleStyle),
                    SizedBox(height: 10.0),
                    SizedBox(height: 5.0),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 100.0,
                          child: Text("배달시간", style: _titleStyle),
                        ),
                        Text(restaurant.time, style: _bodyStyle),
                        // Text(restaurant["time"], style: _bodyStyle),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 100.0,
                          child: Text("휴무일", style: _titleStyle),
                        ),
                        Text(restaurant.closed, style: _bodyStyle),
                        // Text(restaurant["closed"], style: _bodyStyle),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 100.0,
                          child: Text("전화번호", style: _titleStyle),
                        ),
                        Text(restaurant.phone, style: _bodyStyle),
                        // Text(restaurant["phone"], style: _bodyStyle),
                      ],
                    ),
                    SizedBox(height: 15.0),
                  ],
                ),

                // 리뷰
                ListView(

                ),

              ],
            ),
          ),

        ],

      ),

    );
  }
}

class Menu {
  final String name;
  final String price;
  final DocumentReference reference;

  Menu(this.name, this.price, this.reference);

  Menu.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['price'] != null),
        name = map['name'],
        price = map['price'];


  Menu.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);


}
