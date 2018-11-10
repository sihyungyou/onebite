// // 구글, 페이스북, 한입만 계정으로 로그인하기 / 로그인 없이 주문하기

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'home.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  
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
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                Image.asset('assets/diamond.png'),
                SizedBox(height: 16.0),
                Text('한입만'),
              ],
            ),
            SizedBox(height: 120.0),
            MaterialButton(
              child: const Text('Sign in With Google'),
              color: Colors.red[400],
              onPressed: () {
                _testSignInWithGoogle().then((FirebaseUser user) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => HomePage(user: user,)))
                      .catchError((e) => print(e));
                  });
              }),
            SizedBox(height: 12.0),
            // anonymous log in
            MaterialButton(
              child: const Text('Guest'),
              color: Colors.blue[400],
              onPressed: () {
                  signinAnon().then((FirebaseUser user) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => HomePage(user: user,)))
                      .catchError((e) => print(e));
                  });
              }),
            SizedBox(height: 150.0),
            MaterialButton(
              minWidth: 50.0,
              child: const Text('Log-out'),
              color: Colors.grey[300],
              onPressed: () {
                signOut();
              }),              
          ],
        ),
      ),
    );
  }
}
