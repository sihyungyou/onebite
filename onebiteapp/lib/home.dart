import 'package:Shrine/rest_detail.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Shrine/rest_all.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Shrine/favorite.dart';
import 'package:Shrine/history.dart';
import 'rank.dart';

class HomePage extends StatefulWidget {
  // anonymous login user object를 건네받기 위한 변수 선언
  final FirebaseUser user;

  HomePage({this.user});

  @override
  HomePageState createState() {
    return new HomePageState(user: user);
  }
}

class HomePageState extends State<HomePage> {
  final FirebaseUser user;

  HomePageState({this.user});
  final String allImage = 'https://firebasestorage.googleapis.com/v0/b/onebite-cdaee.appspot.com/o/homePage%2Fall.png?alt=media&token=427a0b65-a5fb-4006-86aa-2b7217df0bda';
  final String roulletImage = 'https://firebasestorage.googleapis.com/v0/b/onebite-cdaee.appspot.com/o/homePage%2Froullet.png?alt=media&token=c11f3183-13cd-4100-b993-7195973cf155';
  final String favImage = 'https://firebasestorage.googleapis.com/v0/b/onebite-cdaee.appspot.com/o/homePage%2Ffavorite.png?alt=media&token=16c25dcd-a7c9-456e-b05b-79cf0163b698';

  final String bannerImage = 'https://firebasestorage.googleapis.com/v0/b/onebite-cdaee.appspot.com/o/homePage%2F%E1%84%83%E1%85%A9%E1%86%AB%E1%84%81%E1%85%A1%E1%84%8A%E1%85%B3%E1%84%8B%E1%85%A3%E1%84%89%E1%85%B3.png?alt=media&token=4e62b911-79b5-41f5-b659-2febc2aad94c';
  final String logoImage = 'https://firebasestorage.googleapis.com/v0/b/onebite-cdaee.appspot.com/o/homePage%2F%E1%84%8C%E1%85%A1%E1%84%89%E1%85%A1%E1%86%AB%204.png?alt=media&token=fbeb4805-eea5-418d-a63a-f92fc76cb270';

  final Color googleText = Color.fromRGBO(241, 67, 54, 1);

  List<Restaurant> korean = new List<Restaurant>();

  List<Restaurant> chinese = new List<Restaurant>();

  List<Restaurant> japanese = new List<Restaurant>();

  List<Restaurant> boonSick = new List<Restaurant>();

  List<Restaurant> fastFood = new List<Restaurant>();

  List<Restaurant> allRests = new List<Restaurant>();

  List<String> allNames = new List<String>();

  List<Restaurant> favoriteList = List<Restaurant>();

  List<Restaurant> historyList = List<Restaurant>();

  List<Restaurant> sortedList = List<Restaurant>();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

    void _initList(){
    favoriteList.clear();
    historyList.clear();
  }



  Future _buildList() async {
    _initList();
    
    // print("buildlist in");
    QuerySnapshot querySnapshot =
    await Firestore.instance.collection("restaurant").getDocuments();
    var list = querySnapshot.documents;
    // build init 할 때 user collection -> uid document -> search_history collection -> index 돌면서 추가!
    for (var i = 0; i < list.length; i++) {
      final Restaurant restaurant = Restaurant.fromSnapshot(list[i]);
      setState(() {
        // print(restaurant.name);
        allRests.add(restaurant);
        allNames.add(restaurant.name);
        if (restaurant.type == 'korean')
          korean.add(restaurant);
        else if (restaurant.type == 'chinese')
          chinese.add(restaurant);
        else if (restaurant.type == 'japanese')
          japanese.add(restaurant);
        else if (restaurant.type == 'boonsick')
          boonSick.add(restaurant);
        else if (restaurant.type == 'fastfood')
          fastFood.add(restaurant);
      });
    }

    QuerySnapshot favoriteSnapshot =
    await Firestore.instance.collection("users").document(user.uid).collection("favorite").getDocuments();
    var list1 = favoriteSnapshot.documents;
    for(var i = 0 ; i< list1.length; i ++){
      final Favorite favorite = Favorite.fromSnapshot(list1[i]);
      setState(() {
        for(var j = 0; j< allRests.length; j ++){
          if(allRests[j].name == favorite.name){
            // print("favorite : " + favorite.name);
            favoriteList.add(allRests[j]);
          }
        }
      });
    }
    QuerySnapshot historySnapshot =
    await Firestore.instance.collection("users").document(user.uid).collection("history").getDocuments();
    var list2 = historySnapshot.documents;
    for(var i = 0 ; i < list2.length; i ++){
      final History history = History.fromSnapshot(list2[i]);
      setState(() {
        for(var j = 0; j< allRests.length; j ++){
          if(allRests[j].name == history.name) {
            // print("history : " + history.name);
            historyList.add(allRests[j]);
          }
        }
      });
    }

    allRests.sort((a, b) => b.calls.compareTo(a.calls));  // descending order sorting
    for(var i = 0; i < 3; i++){
      sortedList.add(allRests[i]);
    }
  }
  
  @override
  void initState() {
    _buildList();
  }

  void signOut() async{
    // currentuser로 진짜 signout 되는지 testing 더 필요..
    // signout 이 됐으면 다시 구글로그인 눌렀을 때 다시 구글 이메일 및 비밀번호 요구해야 하지 않나?
    FirebaseAuth.instance.signOut();
    // print('${FirebaseAuth.instance.currentUser()} Signed Out!');
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(227, 220, 212, 1),
      // declare key for draw openener
      key: _scaffoldKey,
      // create new drawer
      drawer: new Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the Drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(height: 100.0),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      color: theme.primaryColor,
                      child:
                      widget.user.isAnonymous == true ?                // 익명로그인의 경우
                      Text(
                        '안녕하세요',
                        style: TextStyle(color: Colors.white),
                      ) :
                      Text(                                     // 구글/페이스북 로그인의 경우
                        '${widget.user.displayName} 님 안녕하세요',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ]),
              decoration: BoxDecoration(
                color: theme.primaryColor
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: theme.primaryColor,
              ),
              title: Text('Home'),
              onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>  HomePage( user: user,)))
            .catchError((e) => print(e));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.calendar_today,
                color : theme.primaryColor,
              ),
              title: Text('이벤트'),
              onTap: () {
                // Navigator.pushNamed(context, '/event_list');
              },
            ),
            ListTile(
              leading: Icon(
                Icons.notifications,
                color : theme.primaryColor,
              ),
              title: Text('공지사항'),
              onTap: () {
                Navigator.pushNamed(context, '/notice_list');
              },
            ),
            ListTile(
              leading: Icon(
                Icons.chat,
                color : theme.primaryColor,
              ),
              title: Text('건의사항'),
              onTap: () {
                // Navigator.pushNamed(context, '/suggestion');
              },
            ),
            ListTile(
              leading: Icon(
                Icons.bug_report,
                color : theme.primaryColor,
              ),
              title: Text('버그신고'),
              onTap: () {
                // Navigator.pushNamed(context, '/bug_report');
              },
            ),
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color : theme.primaryColor,
              ),
              title: Text('로그아웃'),
              onTap: () {
                signOut();
                Navigator.pushNamed(context, '/login');
              },
            ),

          ],
        ),
      ),

      appBar: AppBar(
        leading: IconButton(
          // 이게 햄버거 버튼
          icon: Icon(
            Icons.menu,
            semanticLabel: 'menu',
          ),
          onPressed: () {
            // open drawer here
            return _scaffoldKey.currentState.openDrawer();
          },
        ),
        centerTitle: true,
        title: Image.network(logoImage, scale: 3.0),
      ),

      body: ListView(
        children: <Widget>[
          Container(
              height: 100.0,
              width: 400.0,
              color: Colors.grey,
              child: Image.network(bannerImage),
          ),

          Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Container(
                  decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius:
                    new BorderRadius.all(new Radius.circular(10.0)),
                  ),
                  height: 60.0,
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                     FlatButton(
                          child: Row(
                            children: <Widget>[
                              Image.network(allImage, width: 20.0),
                              SizedBox(width:5.0),

                              Text("전체식당", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15.0),)
                            ],
                          ),
                         onPressed: () {
                           Navigator.of(context)
                               .push(MaterialPageRoute(
                               builder: (BuildContext context) =>
                                    RestAllPage(korean: korean, chinese : chinese, japanese: japanese, boonSick: boonSick, fastFood : fastFood, allRests : allRests, allNames : allNames, user: user)))
                               .catchError((e) => print(e));
                         }
                     ),
                     FlatButton(
                         child: Row(
                           children: <Widget>[
                             Image.network(favImage, width: 20.0),
                             SizedBox(width:5.0),
                             Text("즐겨찾기", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15.0),)
                           ],
                         ),
                         onPressed:() {
                           Navigator.of(context)
                               .push(MaterialPageRoute(
                               builder: (BuildContext context) =>
                                   FavoritePage(
                                       user: user,
                                       )))
                               .catchError((e) => print(e));
                         }
                     ),

                     FlatButton(
                         child: Row(
                           children: <Widget>[
                             Image.network(roulletImage, width: 20.0),                              SizedBox(width:5.0),
                             Text("못 골라?", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15.0),)
                           ],
                         ),
                         onPressed:() {
                         }
                     ),
                  ],
                )
                ),
                // favorite
                SizedBox(height: 10.0),
                Container(
                  decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius:
                    new BorderRadius.all(new Radius.circular(10.0)),
                  ),
                  height: 175.0,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15.0, 10.0, 10.0, 0.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text("내가 좋아하는 한입만 식당", style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 15.0, fontWeight: FontWeight.w800)),
                                ],
                              ),
                              Divider(),
                              user.isAnonymous ? Container(
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(height: 35.0,),
                                    Text("로그인 후 이용 가능합니다", textAlign: TextAlign.center,)
                                  ],
                                ),
                              ) : 
                              favoriteList.length == 0 ? Container(
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(height: 35.0,),
                                    Text("아직 좋아하는 식당이 없어요!",  textAlign: TextAlign.center,),
                                    Text("식당을 검색한 후 하트를 눌러보세요~ ",  textAlign: TextAlign.center,)
                                  ],
                                )
                              ) : Container(

                                height: 100.0,
                                width: 400.0,
                                child: ListView(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  children: favoriteList.map((restaurant){
                                    return Container(
                                      height: 130.0,
                                      width: 80.0,
                                      child: ListTile(
                                          contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                                          title: Column(
                                            children: <Widget>[
                                              CircleAvatar(
                                                radius: 30.0,
                                                backgroundImage: Image.network('${restaurant.logo}').image,
                                              ),
                                              SizedBox(height: 10.0),
                                              Text(
                                                  restaurant.name,
                                                  maxLines: 2,
                                                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0),
                                                  textAlign: TextAlign.center,
                                              ),

                                            ],
                                          ),
                                          onTap: () {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                                builder: (BuildContext context) =>
                                                    DetailPage(
                                                        user: user,
                                                        restaurant: restaurant,
                                                        previous: "home")))
                                                .catchError((e) => print(e));
                                          }
                                      ),
                                    );

                                  }).toList(),
                                ),
                              ),



                            ],
                          ),
                        ),
                        Container(

                          color: Colors.white,
                          height: 20.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              ButtonTheme(
                                  minWidth: 40.0,
                                  child: FlatButton(
                                      padding: EdgeInsets.symmetric(horizontal: 0.0),

                                  child: favoriteList.length == 0 ? Text("더보기", style: TextStyle(color: Colors.white)) : Text("더보기", style: TextStyle(fontSize: 12.0, color: Theme.of(context).primaryColor)),

                                  onPressed:() {
                                    if(favoriteList.length != 0)
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              FavoritePage(
                                                  user: user,
                                              )))
                                          .catchError((e) => print(e));
                                  }
                              )
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                ),

                // history
                SizedBox(height: 10.0),
                Container(
                  decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius:
                    new BorderRadius.all(new Radius.circular(10.0)),
                  ),
                  height: 175.0,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15.0, 10.0, 10.0, 0.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text("내가 이용한 한입만 식당", style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 15.0, fontWeight: FontWeight.w800)),
                                  Divider(),
                                ],
                              ),
                              Divider(),
                              user.isAnonymous ? Container(
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(height: 35.0,),
                                    Text("로그인 후 이용 가능합니다", textAlign: TextAlign.center,)
                                  ],
                                ),
                              ) :
                              historyList.length == 0 ? Container(
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(height: 35.0,),
                                      Text("아직 이용한 식당이 없어요!",  textAlign: TextAlign.center,),
                                      Text("식당을 검색하고 주문해보세요~",  textAlign: TextAlign.center,)
                                    ],
                                  )
                              ) : Container(
                                child: Container(
                                  height: 100.0,
                                  width: 400.0,
                                  child: ListView(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    children: historyList.map((restaurant){
                                      return Container(
                                        height: 130.0,
                                        width: 80.0,

                                        child: ListTile(
                                            contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                                            title: Column(
                                              children: <Widget>[
                                                CircleAvatar(
                                                  radius: 30.0,
                                                  backgroundImage: Image.network('${restaurant.logo}').image,
                                                ),
                                                SizedBox(height: 10.0),
                                                Text(
                                                    restaurant.name,
                                                    maxLines: 2,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0)
                                                ),

                                              ],
                                            ),
                                            onTap: () {
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                  builder: (BuildContext context) =>
                                                      DetailPage(
                                                          user: user,
                                                          restaurant: restaurant,
                                                          previous: 'home')))
                                                  .catchError((e) => print(e));
                                            }
                                        ),
                                      );

                                    }).toList(),
                                  ),
                                ),
                              ),


                            ],
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          height: 20.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              ButtonTheme(
                                minWidth: 40.0,
                                child: FlatButton(
                                  child: historyList.length == 0 ? Text("더보기", style: TextStyle(color: Colors.white)) : Text("더보기", style: TextStyle(fontSize: 12.0, color: Theme.of(context).primaryColor)),
                                  padding: EdgeInsets.symmetric(horizontal: 0.0),
                                  disabledColor: Colors.white,

                                  onPressed:() {
                                    if(historyList.length != 0)
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            HistoryPage(
                                                user: user,
                                                )))
                                        .catchError((e) => print(e));
                                  }
                              )
                              )

                            ],
                          ),
                        )

                      ],
                    ),
                  ),
                ),
                // 식당 랭킹
                SizedBox(height: 10.0),
                Container(
                  decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius:
                    new BorderRadius.all(new Radius.circular(10.0)),
                  ),
                  height: 175.0,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15.0, 10.0, 10.0, 0.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text("한입만 식당 랭킹", style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 15.0, fontWeight: FontWeight.w800)),
                                ],
                              ),
                              Divider(),
                              user.isAnonymous ? Container(
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(height: 35.0,),
                                    Text("로그인 후 이용 가능합니다", textAlign: TextAlign.center,)
                                  ],
                                ),
                              ) : 
                              // 여긴 로그인 했으면 무조건 뭔가 보임 (히스토리나 즐겨찾기가 아니고 전체 유저의 데이터를 축적 해놓은 것이기 때문에)
                              Container(
                                height: 100.0,
                                width: 400.0,
                                child: ListView(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  children: sortedList.map((restaurant){
                                    return Container(
                                      height: 100.0,
                                      width: 80.0,
                                      child: ListTile(
                                        contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                                          title: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              CircleAvatar(
                                                radius: 30.0,
                                                backgroundImage: Image.network('${restaurant.logo}').image,
                                              ),
                                              Text(
                                                  restaurant.name,
                                                  maxLines: 2,
                                                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0),
                                                  textAlign: TextAlign.center,
                                              ),

                                            ],
                                          ),
                                          onTap: () {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                                builder: (BuildContext context) =>
                                                    DetailPage(
                                                        user: user,
                                                        restaurant: restaurant,
                                                        previous: "home")))
                                                .catchError((e) => print(e));
                                          }
                                      ),
                                    );

                                  }).toList(),
                                ),
                              ),

                          Container(

                          color: Colors.white,
                          height: 20.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              ButtonTheme(
                                  minWidth: 40.0,
                                  child: FlatButton(
                                      padding: EdgeInsets.symmetric(horizontal: 0.0),

                                  child: favoriteList.length == 0 ? Text("더보기", style: TextStyle(color: Colors.white)) : Text("더보기", style: TextStyle(fontSize: 12.0, color: Theme.of(context).primaryColor)),

                                  onPressed:() {
                                    if(favoriteList.length != 0)
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              RankPage(
                                                  user: user,
                                                  sortedlist: sortedList)))
                                          .catchError((e) => print(e));
                                  }
                              )
                              )
                            ],
                          ),
                        ),
                            ],
                          ),
                      ),
                      ],
                    ),
                  ),
                ),

              ],
            )
          )

        ],
      )


    );
  }
}

