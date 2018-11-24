// // 구글, 페이스북, 한입만 계정으로 로그인하기 / 로그인 없이 주문하기

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'home.dart';
import 'rest_all.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final String googleIcon = 'https://firebasestorage.googleapis.com/v0/b/onebite-cdaee.appspot.com/o/loginPage%2Ficon2_signin.png?alt=media&token=7cc540c8-d211-44f0-af8a-7f2a87930f56';
  final String facebookIcon = 'https://firebasestorage.googleapis.com/v0/b/onebite-cdaee.appspot.com/o/loginPage%2Flogo1_signin.png?alt=media&token=3c408e37-3120-47e6-8c5d-6fc8bee59fd3';
  final String onebiteIcon = 'https://firebasestorage.googleapis.com/v0/b/onebite-cdaee.appspot.com/o/loginPage%2Ficon3_signin.png?alt=media&token=92b545c9-7b84-44a2-9adb-d352bb887c28';
  final String onebiteLogo = 'https://firebasestorage.googleapis.com/v0/b/onebite-cdaee.appspot.com/o/loginPage%2Flogo_login.png?alt=media&token=d347f594-d651-4395-9c9b-ea786e227314';
  final String backgroundImage = 'https://firebasestorage.googleapis.com/v0/b/onebite-cdaee.appspot.com/o/loginPage%2F%E1%84%8C%E1%85%A1%E1%84%89%E1%85%A1%E1%86%AB%202.png?alt=media&token=bc6f5970-8b98-48cd-93d8-fd5b3a5de0dc';
  final Color onebiteButton = Color.fromRGBO(255, 112, 74, 1);
  final Color facebookButton = Color.fromRGBO(63, 83, 139, 1);
  final Color googleButton = Colors.white;
  final Color googleText = Color.fromRGBO(241, 67, 54, 1);
  Future<FirebaseUser> _testSignInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final FirebaseUser user = await _auth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    print('User Name : ${user.displayName}');

    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    // return 'signInWithGoogle succeeded: $user';
    return user;

  }



  Future<FirebaseUser> signinAnon() async {
    FirebaseUser user = await firebaseAuth.signInAnonymously();
    print("Signed in ${user.uid}");
    return user;
  }
  void signOut() {
    firebaseAuth.signOut();
    print("Signed Out!");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(backgroundImage),
                  fit: BoxFit.cover,

                )
            ),
          ),
          ListView(
            children: <Widget>[
              SizedBox(height: 100.0),
              SizedBox(
                height: 170.0,
                child: Image.network(onebiteLogo),
              ),
              SizedBox(height: 100.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.0),
                child: ButtonTheme(
                  height: 40.0,
                  child: FlatButton(
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 25.0,
                            height: 25.0,
                            child: Image.network(facebookIcon),
                          ),
                          Container(
                            width: 200.0,
                            alignment: Alignment.center,
                            child: Text("Facebook 계정으로 로그인", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17.0, color: Colors.white)),
                          )
                        ],
                      ),
                      color: facebookButton,

                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)
                      ),
                      onPressed: () {

                      }
                  ),
                ),
              ),
              // anonymous
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.0),
                child: ButtonTheme(
                  height: 40.0,
                  child: FlatButton(
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 25.0,
                            height: 25.0,
                            child: Image.network(googleIcon),
                          ),
                          Container(
                            width: 200.0,
                            alignment: Alignment.center,
                            child: Text("Google 계정으로 로그인", style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w800, color: googleText)),
                          )
                        ],
                      ),
                      color: googleButton,

                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)
                      ),
                      onPressed: () {
                        // _testSignInWithGoogle().then((FirebaseUser user){
                        //   Navigator.of(context).push(MaterialPageRoute(
                        //       builder: (BuildContext context) => HomePage(user:user)))
                        //       .catchError((e) => print(e));
                        // });
                        _testSignInWithGoogle().then((FirebaseUser user){
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => RestAllPage(user:user)))
                              .catchError((e) => print(e));
                        });
                      }
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.0),
                child: ButtonTheme(
                  height: 40.0,
                  child: FlatButton(
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 25.0,
                            height: 25.0,
                            child: Image.network(onebiteIcon),
                          ),
                          Container(
                            width: 200.0,
                            alignment: Alignment.center,
                            child: Text("한입만 계정으로 로그인", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17.0, color: Colors.white)),
                          )
                        ],
                      ),
                      color: onebiteButton,

                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)
                      ),
                      onPressed: () {

                      }
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.0),
                child: ButtonTheme(
                  height: 40.0,
                  child: FlatButton(
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 25.0,
                            height: 25.0,
                          ),
                          Container(
                            width: 200.0,
                            alignment: Alignment.center,
                            child: Text("로그인 없이 주문하기", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17.0, color: Colors.white)),
                          )
                        ],
                      ),
                      color: Colors.transparent,

                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)
                      ),
                      onPressed: () {
                        signinAnon().then((FirebaseUser user){
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => HomePage(user:user)))
                              .catchError((e) => print(e));
                        });
                      }
                  ),
                ),
              ),
            ],
          ),
        ],
      ),

    );
  }
}

