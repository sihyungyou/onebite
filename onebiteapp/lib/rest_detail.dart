import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Shrine/rest_all.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:Shrine/write_review.dart';

class DetailPage extends StatefulWidget {
  final FirebaseUser user;
  final Restaurant restaurant;
  DetailPage({Key key, this.user, this.restaurant});
  DetailPageState createState() => DetailPageState(user: this.user, restaurant: this.restaurant);
}

class DetailPageState extends State<DetailPage> with SingleTickerProviderStateMixin{
  final FirebaseUser user;
  final Restaurant restaurant;
  List<Menu> menu = List<Menu>();
  List<Review> review = List<Review>();
  bool favorited = false;
  final Color onebiteButton = Color.fromRGBO(255, 112, 74, 1);
  final Color writeFloatingButton = Color.fromRGBO(21, 170, 210, 1);
  final String iconWrite = "https://firebasestorage.googleapis.com/v0/b/onebite-cdaee.appspot.com/o/detailPage%2Ficon_write.png?alt=media&token=770d2c62-362e-4ec4-af72-51b1e318dade";
  var rating = 0.0;
  TabController _controller;

  TextStyle _titleStyle = TextStyle(fontWeight: FontWeight.w600, fontSize: 15.0);
  TextStyle _bodyStyle = TextStyle(fontWeight: FontWeight.w300, fontSize: 15.0);
  TextStyle _tabTitleStyle = TextStyle(fontWeight: FontWeight.w600, fontSize: 20.0, color: Colors.black87);
  TextStyle _orderButtonStyle = TextStyle(fontWeight: FontWeight.w600, fontSize: 20.0, color: Colors.white);
  DetailPageState({Key key, this.user, this.restaurant});

  Future<void> _buildList() async {
    QuerySnapshot menuSnapshot = await Firestore.instance.collection("restaurants").document(restaurant.reference.documentID).collection('menu').getDocuments();
    var menuList = menuSnapshot.documents;
    print(menuList.length);
    for (var i = 0; i < menuList.length; i++) {
      setState(() {
        menu.add(Menu.fromSnapshot(menuList[i]));
      });

      print(menu[i].name);
      print(menu[i].price);

    }

    QuerySnapshot reviewSnapshot = await Firestore.instance.collection("restaurants").document(restaurant.reference.documentID).collection('review').getDocuments();
    var reviewList = reviewSnapshot.documents;
    print(reviewList.length);
    for (var i = 0; i < reviewList.length; i++) {
      setState(() {
        review.add(Review.fromSnapshot(reviewList[i]));

      });
      print(review[i].author);
      print(review[i].date);
      print(review[i].rate);
      print(review[i].context);
      rating += double.parse(review[i].rate);

    }
    rating = rating/reviewList.length;
  }

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _buildList().asStream();
    });
    _controller = new TabController(length: 3, vsync: this);

    super.initState();
  }

  _launchURL() async {
    String url = 'tel:'+restaurant.phone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Image.network(iconWrite),
        backgroundColor: writeFloatingButton,
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => WriteReviewPage(user:user, restaurant: restaurant,)))
              .catchError((e) => print(e));
        }

      ),
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
              _launchURL();
            }
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: IconButton(
                icon: Icon(Icons.arrow_back, color: onebiteButton),
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => RestAllPage(user:user)))
                      .catchError((e) => print(e));
                }

            ),
          ),
          Padding(
              padding : EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  Text(restaurant.name, textAlign: TextAlign.center, style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w800)),
                  SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SmoothStarRating(
                        rating: rating,
                        size: 25,
                        starCount: 5,
                        color: Colors.orange,
                        borderColor: Colors.orange,

                      ),
                      SizedBox(width: 5.0),
                      Text(rating.toString(), textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500)),

                    ],
                  ),


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
                ListView.builder(
                    itemCount: menu.length,
                    itemBuilder: (context, index){
                      return ListTile(
                        title: Text(menu[index].name),
                        subtitle: Text(menu[index].price + "원"),
                      );
                    }

                ),
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
                      ],
                    ),
                    SizedBox(height: 15.0),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
                  child: ListView.builder(
                      itemCount: review.length,
                      itemBuilder: (context, index){
                        return ListTile(
                          title: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(review[index].author, style: _tabTitleStyle),
                                  SizedBox(width: 10.0),
                                  Text(review[index].date, style: _bodyStyle),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  SmoothStarRating(
                                    rating: double.parse(review[index].rate),
                                    size: 25,
                                    starCount: 5,
                                    color: Colors.orange,
                                    borderColor: Colors.orange,
                                    allowHalfRating: true,

                                  ),
                                  SizedBox(width: 5.0),
                                  Text(review[index].rate, style: _bodyStyle),

                                ],
                              ),
                              SizedBox(height: 20.0)
                            ],
                          ),
                          subtitle: SizedBox(
                            height: 60.0,
                            child: Text(review[index].context, style: _bodyStyle),
                          ),
                        );
                      }

                  ),
                )


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

class Review {
  final String author;
  final String date;
  final String rate;
  final String context;
  final DocumentReference reference;

  Review(this.author, this.date, this.rate, this.context, this.reference);

  Review.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['author'] != null),
        assert(map['date'] != null),
        assert(map['rate'] != null),
        assert(map['context'] != null),
        author = map['author'],
        date = map['date'],
        rate = map['rate'],
        context = map['context'];


  Review.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);


}


