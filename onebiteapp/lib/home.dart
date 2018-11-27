import 'package:flutter/material.dart';
import 'rest_detail.dart';
import 'model/products_repository.dart';
import 'model/product.dart';
import 'package:firebase_auth/firebase_auth.dart';




class HomePage extends StatelessWidget {
  // anonymous login user object를 건네받기 위한 변수 선언
  final FirebaseUser user;
  final String logoImage = 'https://firebasestorage.googleapis.com/v0/b/onebite-cdaee.appspot.com/o/homePage%2F%E1%84%8C%E1%85%A1%E1%84%89%E1%85%A1%E1%86%AB%204.png?alt=media&token=fbeb4805-eea5-418d-a63a-f92fc76cb270';

  // 전달받는 constructor
  HomePage({this.user});

  //this is scaffoldkey for drawer openenr
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  // HomePage({Key key, @required this.products}) : super(key: key);


  @override
  Widget build(BuildContext context) {
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
              child: Column(children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(height: 100.0),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      child: 
                      user.displayName == null ?                // 익명로그인의 경우
                      Text(
                        '안녕하세요',
                        style: TextStyle(color: Colors.white),                        
                      ) :
                      Text(                                     // 구글/페이스북 로그인의 경우
                        '${user.displayName} 님 안녕하세요',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ]),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
                color: Colors.lightBlue,
              ),
              title: Text('Home'),
              onTap: () {
                print('home, go to home page');
                Navigator.pushNamed(context, '/home');
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.calendar_today,
                color: Colors.lightBlue,
              ),
              title: Text('이벤트'),
              onTap: () {
                print('event, go to event_list page');
                // Navigator.pushNamed(context, '/event_list');
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.notifications,
                color: Colors.lightBlue,
              ),
              title: Text('공지사항'),
              onTap: () {
                print('notice, go to nocie_list page');
                Navigator.pushNamed(context, '/notice_list');
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.chat,
                color: Colors.lightBlue,
              ),
              title: Text('건의사항'),
              onTap: () {
                print('suggestion, go to suggestion page');
                Navigator.pushNamed(context, '/suggestion');
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.bug_report,
                color: Colors.lightBlue,
              ),
              title: Text('버그신고'),
              onTap: () {
                print('bug report, go to bug_report page');
                Navigator.pushNamed(context, '/bug_report');
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.exit_to_app,
                color: Colors.lightBlue,
              ),
              title: Text('로그아웃'),
              onTap: () {
                // print('log out, go to login page');
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
            print('Menu button');
            // open drawer here
            return _scaffoldKey.currentState.openDrawer();
          },
        ),
        centerTitle: true,
        title: Image.network(logoImage, scale: 3.0),
      ),

      // 이거 빼도 될듯?
      body:

      Column(

        children: <Widget>[
          Container(height: 90.0, color: Colors.grey),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 10.0),
                Container(
                  height: 60.0,
                  color: Colors.white,
                  child: ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: <Widget>[
                     FlatButton(
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.restaurant),
                            ],
                          ),
                          onPressed:() {}
                    ),
                     FlatButton(
                         child: Row(
                           children: <Widget>[
                             Icon(Icons.restaurant),
                           ],
                         ),
                         onPressed:() {}
                     ),
                     FlatButton(
                         child: Row(
                           children: <Widget>[
                             Icon(Icons.restaurant),
                           ],
                         ),
                         onPressed:() {}
                     ),
                  ],
                )
                ),

              ],
            )
          )

        ],
      )


    );
  }
}
