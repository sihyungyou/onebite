import 'package:Shrine/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Shrine/rest_all.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:Shrine/write_review.dart';
import 'history.dart';
import 'favorite.dart';
// import 'package:english_words/english_words.dart';

class DetailPage extends StatefulWidget {
  final FirebaseUser user;
  final Restaurant restaurant;
  final String previous;
  DetailPage({Key key, this.user, this.restaurant, this.previous});
  DetailPageState createState() =>
      DetailPageState(user: this.user, restaurant: this.restaurant, previous: this.previous);
}

class DetailPageState extends State<DetailPage> with SingleTickerProviderStateMixin {
  final FirebaseUser user;
  final Restaurant restaurant;
  final String previous;
  List<DocumentSnapshot> favList = List<DocumentSnapshot>();
  List<Menu> menu = List<Menu>();
  List<Review> review = List<Review>();
  List<TopMenu> topMenu = List<TopMenu>();
  List<Card> topMenuCard = List<Card>();
  bool favorited = false;
  final Color onebiteButton = Color.fromRGBO(255, 112, 74, 1);
  final Color writeFloatingButton = Color.fromRGBO(21, 170, 210, 1);
  final String iconWrite =
      "https://firebasestorage.googleapis.com/v0/b/onebite-cdaee.appspot.com/o/detailPage%2Ficon_write.png?alt=media&token=770d2c62-362e-4ec4-af72-51b1e318dade";
  final String onebiteIcon =
      'https://firebasestorage.googleapis.com/v0/b/onebite-cdaee.appspot.com/o/loginPage%2Ficon3_signin.png?alt=media&token=92b545c9-7b84-44a2-9adb-d352bb887c28';
  bool isExpanded1 = false;
  bool isExpanded2 = false;
  bool isExpanded3 = false;

  var rating = 0.0;
  TabController _controller;

  TextStyle _titleStyle =
      TextStyle(fontWeight: FontWeight.w600, fontSize: 15.0);
  TextStyle _bodyStyle = TextStyle(fontWeight: FontWeight.w300, fontSize: 15.0);
  TextStyle _tabTitleStyle = TextStyle(
      fontWeight: FontWeight.w600, fontSize: 20.0, color: Colors.black87);
  TextStyle _orderButtonStyle = TextStyle(
      fontWeight: FontWeight.w600, fontSize: 20.0, color: Colors.white);
  DetailPageState({Key key, this.user, this.restaurant, this.previous});

  UpdateCalls() async {
    // print('update calls');
    Firestore.instance.collection('restaurant').document(restaurant.reference.documentID).updateData(
      {
        'calls' : restaurant.calls++,
      });
  }

  Future<void> _buildList() async {
    QuerySnapshot favSnapshot = await Firestore.instance.collection('users').document('${user.uid}').collection('favorite').getDocuments();
    favList = favSnapshot.documents;
    // print('test console');
    // print(favList[0].data['name']);
    for (var i = 0; i < favList.length; i++){
      if(favList[i].data['name'] == restaurant.name) {
        favorited = true;
        break;
      }
    }

    QuerySnapshot menuSnapshot = await Firestore.instance.collection("restaurant").document(restaurant.reference.documentID).collection('menu').getDocuments();
    var menuList = menuSnapshot.documents;

    // print("menu length = " + menuList.length.toString());
    for (var i = 0; i < menuList.length; i++) {
      setState(() {
        menu.add(Menu.fromSnapshot(menuList[i]));
      });

      // print(menu[i].name);
      // print(menu[i].price);
    }

    QuerySnapshot reviewSnapshot = await Firestore.instance
        .collection("restaurant")
        .document(restaurant.reference.documentID)
        .collection('review')
        .getDocuments();
    var reviewList = reviewSnapshot.documents;
    // print(reviewList.length);
    // print("review length = " + reviewList.length.toString());


    for (var i = 0; i < reviewList.length; i++) {
      setState(() {
        review.add(Review.fromSnapshot(reviewList[i]));
      });
      // print(review[i].author);
      // print(review[i].date);
      // print(review[i].rate);
      // print(review[i].context);
      rating += double.parse(review[i].rate);
    }
    if(reviewList.length != 0)rating = rating / reviewList.length;

    QuerySnapshot topMenuSnapshot = await Firestore.instance
        .collection("restaurant")
        .document(restaurant.reference.documentID)
        .collection('topmenu')
        .getDocuments();

    var topMenuList = topMenuSnapshot.documents;
    // print(topMenuList.length);
    // print("topMenuList length = " + topMenuList.length.toString());

    for (var i = 0; i < topMenuList.length; i++) {
      setState(() {
        topMenu.add(TopMenu.fromSnapshot(topMenuList[i]));
      });
      // print(topMenu[i].name);
      // print(topMenu[i].price);
    }
    topMenuCard = _buildGridCards(context);
  }

  @override
  void initState() {
    setState(() {
      _buildList();
    });
    _controller = new TabController(length: 3, vsync: this);

    super.initState();
  }

  List<Card> _buildGridCards(BuildContext context) {
    if (topMenu == null || topMenu.isEmpty) {
      return const <Card>[];
    }

    final ThemeData theme = Theme.of(context);

    return topMenu.map((product) {
      return Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[
            AspectRatio(
              aspectRatio: 18 / 11,
              child: Image.network(
                product.image,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              product.name,
              style: _tabTitleStyle,
              maxLines: 1,
            ),
            SizedBox(height: 8.0),
            Text(
              product.price + "원",
              style: _bodyStyle,
            ),
          ],
        ),
      );
    }).toList();
  }

  _launchURL() async {
    String url = 'tel:' + restaurant.phone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget ReviewDelete(String uid, int index) {
    if (uid == user.uid) {
      return IconButton(
        icon: Icon(Icons.delete, size: 15.0,),
        onPressed: () {
          print('deleted!');
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text('리뷰를 삭제하시겠습니까?'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('예'),
                    onPressed: () {
                      // delete
                      Firestore.instance.collection('restaurant').document(restaurant.reference.documentID).collection('review').document('${uid}').delete();
                      setState(() {
                        review.removeAt(index);
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: Text('아니오'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            }
          );
        },
      );
    }
    else return Text(' ');
  }
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
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
            onPressed: () {
              // 현재로써는 결제까지 안가기 떄문에 call 버튼 누르면 history로 추가
              // history 내역도 log in 안하면 setData 부분 막아두기
              // calls++;
              Firestore.instance.collection('users').document('${user.uid}').collection('history').document('${restaurant.name}')
              .setData(({
                'name' : '${restaurant.name}',
              }));
              UpdateCalls();
              // print('history : ${restaurant.name} added!');
              _launchURL();
            }),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                alignment: Alignment.topLeft,
                child: IconButton(
                    icon: Icon(Icons.arrow_back, color: onebiteButton),
                    onPressed: () {
                      print(previous);
                      if(previous == 'rest_all') {
                        // print('go to rest_all');
                        Navigator.of(context).pop();
                      }
                      else if (previous == 'home') {
                        // print('go to home);
                        Navigator.of(context).pop();
                      }
                      else if(previous == 'restall') {
                        // print('restall');
                        Navigator.of(context).pop(); 
                      }
                      else if(previous == 'history') {
                        // print('go to history');
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                HistoryPage(
                                  user: user,
                                )))
                            .catchError((e) => print(e));
                      }
                      else if(previous == 'favorite') {
                        // print('go to favorite');
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                FavoritePage(
                                  user: user,
                                )))
                            .catchError((e) => print(e));
                      }
                      else if(previous == 'review') {
                        // print('go to rest_all but consider review');
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      }
                    }),

              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      Text(restaurant.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.w800)),
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
                          Text(rating.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.w500)),
                        ],
                      ),
                      Container(
                        height: 35.0,
                        child: Row(
                          children: <Widget>[
                            SizedBox(width: 280.0),
                            IconButton(
                                iconSize: 20.0,
                                // db 들어가서 현재 rest name을 가진 favorite document가 있으면 color fill
                                // 아니면 border
                                icon: favorited
                                    ? Icon(Icons.favorite, color: Colors.red)
                                    : Icon(Icons.favorite_border,
                                        color: Colors.red),
                                onPressed: () {
                                  // favorited => db에 user collection -> user.uid document생성 -> favorite collection -> random generate document -> name field : this restaurant's name
                                  // anonymous 는 favorite 막는 기능 추가하기
                                  if (user.isAnonymous) {
                                    // 익명 로그인일 경우 팝업 창 띄워주기
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog (
                                            // title: Text('로그인 후에 이용 가능한 기능입니다'),
                                            content: Text('로그인 후에 이용 가능한 기능입니다'),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text('로그인'),
                                                onPressed: () {
                                                  // 그 자리에서 바로 로그인 유도하기! go to login page
                                                  Navigator.pushNamed(context, '/login');
                                                },
                                              ),
                                              FlatButton(
                                                child: Text('닫기'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              )
                                            ],
                                          );
                                      }
                                    );
                                  }
                                  else {
                                    // 익명 로그인이 아닐 경우
                                    if (!favorited) {
                                    // if it wasn't favorite, add to firebase 
                                    Firestore.instance
                                        .collection('users')
                                        .document('${user.uid}')
                                        .collection('favorite')
                                        .document('${restaurant.name}')
                                        .setData(({
                                          'name': '${restaurant.name}',
                                        }));
                                        print('favorite : ${restaurant.name} added!');
                                  }
                                  if (favorited) {
                                    Firestore.instance.collection('users').document('${user.uid}').collection('favorite').document('${restaurant.name}').delete();
                                  }
                                  setState(() {
                                    favorited = !favorited;
                                  });
                                  }
                                }),
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
                          restaurant.deliveryFee == '없음' ? 
                          Text('없음') :
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
                          restaurant.minimumOrder == '없음' ? 
                          Text('없음') :
                          Text(restaurant.minimumOrder + "원",
                              style: _bodyStyle),
                        ],
                      ),
                      SizedBox(height: 15.0),
                    ],
                  )),
              Container(height: 15.0, color: onebiteButton),
              new Container(
                child: new TabBar(
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(width: 2.0, color: theme.primaryColor),
                  ),
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
                    CustomScrollView(
                      slivers: <Widget>[
                        SliverGrid(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10.0,
                            crossAxisSpacing: 10.0,
                            childAspectRatio: 8.0 / 9.0,
                          ),
                          delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                            return topMenuCard[index];
                          }, childCount: topMenu.length),
                        ),
                        SliverList(
                          delegate: SliverChildListDelegate([
                            ExpansionPanelList(
                              expansionCallback: (int a, bool b) {
                                setState(() {
                                  if (a == 0)
                                    isExpanded1 = !isExpanded1;
                                  else if (a == 1)
                                    isExpanded2 = !isExpanded2;
                                  else if (a == 2) isExpanded3 = !isExpanded3;
                                });
                              },
                              children: [
                                ExpansionPanel(
                                  headerBuilder:
                                      (BuildContext context, bool isExpanded) {
                                    return Row(
                                      children: <Widget>[
                                        SizedBox(width: 20.0),
                                        Text(
                                          "메뉴소개",
                                          style: _tabTitleStyle,
                                        ),
                                      ],
                                    );
                                  },
                                  isExpanded: isExpanded1,
                                  body: ColumnBuilder(
                                      itemCount: menu.length,
                                      itemBuilder: (context, index) {
                                        // print("메뉴 : " + index.toString());

                                        return ListTile(
                                          title: Text(menu[index].name),
                                          subtitle:
                                              Text(menu[index].price + "원"),
                                        );
                                      }),
                                )
                              ],
                            ),
                          ]),
                        )
                      ],
                    ),

                    // 영업 정보
                    ListView(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
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
                        child: Stack(
                          children: <Widget>[
                            ListView.builder(
                                itemCount: review.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Text(review[index].author,
                                                style: _tabTitleStyle),
                                            SizedBox(width: 10.0),
                                            Text(review[index].date,
                                                style: _bodyStyle),
                                            // user.uid 랑 비교해서 삭제가능하도록
                                            ReviewDelete(review[index].uid, index),
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            SmoothStarRating(
                                              rating: double.parse(
                                                  review[index].rate),
                                              size: 25,
                                              starCount: 5,
                                              color: Colors.orange,
                                              borderColor: Colors.orange,
                                              allowHalfRating: true,
                                            ),
                                            SizedBox(width: 5.0),
                                            Text(review[index].rate,
                                                style: _bodyStyle),
                                          ],
                                        ),
                                        SizedBox(height: 20.0)
                                      ],
                                    ),
                                    subtitle: SizedBox(
                                      height: 60.0,
                                      child: Text(review[index].context,
                                          style: _bodyStyle),
                                    ),
                                  );
                                }),
                            Positioned(
                              right: 10.0,
                              bottom: 50.0,
                              child: FloatingActionButton(
                                  child: Image.network(iconWrite),
                                  backgroundColor: writeFloatingButton,
                                  onPressed: () {
                                    if(user.isAnonymous){
                                      // 익명 로그인일 경우 팝업 창 띄워주기
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog (
                                            // title: Text('로그인 후에 이용 가능한 기능입니다'),
                                            content: Text('로그인 후에 이용 가능한 기능입니다'),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text('로그인'),
                                                onPressed: () {
                                                  // 그 자리에서 바로 로그인 유도하기! go to login page
                                                  Navigator.pushNamed(context, '/login');
                                                },
                                              ),
                                              FlatButton(
                                                child: Text('닫기'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              )
                                            ],
                                          );
                                        }
                                      );                                      
                                    }
                                    else {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  WriteReviewPage(
                                                    user: user,
                                                    restaurant: restaurant,
                                                  )))
                                          .catchError((e) => print(e));
                                    }
                                  }),
                            )
                          ],
                        ))
                  ],
                ),
              ),
            ]),
          )
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
  final String uid;
  final DocumentReference reference;

  Review(this.author, this.date, this.rate, this.context, this.uid, this.reference);

  Review.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['author'] != null),
        assert(map['date'] != null),
        assert(map['rate'] != null),
        assert(map['context'] != null),
        assert(map['uid'] !=null),
        author = map['author'],
        date = map['date'],
        rate = map['rate'],
        context = map['context'],
        uid = map['uid'];

  Review.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}

class TopMenu {
  final String price;
  final String name;
  final String image;
  final DocumentReference reference;

  TopMenu(this.price, this.name, this.reference, this.image);

  TopMenu.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['price'] != null),
        assert(map['name'] != null),
        assert(map['image'] != null),
        price = map['price'],
        name = map['name'],
        image = map['image'];

  TopMenu.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}

class ColumnBuilder extends StatelessWidget {
  final IndexedWidgetBuilder itemBuilder;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection textDirection;
  final VerticalDirection verticalDirection;
  final int itemCount;

  const ColumnBuilder({
    Key key,
    @required this.itemBuilder,
    @required this.itemCount,
    this.mainAxisAlignment: MainAxisAlignment.start,
    this.mainAxisSize: MainAxisSize.max,
    this.crossAxisAlignment: CrossAxisAlignment.center,
    this.textDirection,
    this.verticalDirection: VerticalDirection.down,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: new List.generate(
          this.itemCount, (index) => this.itemBuilder(context, index)).toList(),
    );
  }
}
