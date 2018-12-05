// 전체식당
import 'package:Shrine/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'rest_detail.dart';
import 'rest_all.dart';

class FavoritePage extends StatefulWidget {
  @override
  final FirebaseUser user;
  FavoritePage({Key key, this.user});
  _FavoritePageState createState() => _FavoritePageState(user: user);
}

class _FavoritePageState extends State<FavoritePage> {
  final FirebaseUser user;
  List<Restaurant> favoriteList = List<Restaurant>();
  List<Favorite> favorite = List<Favorite>();
  _FavoritePageState({Key key, this.user});

  Future _buildList() async {
    // print("buildlist in");
    QuerySnapshot favoriteSnapshot =
    await Firestore.instance.collection("users").document(user.uid).collection("favorite").getDocuments();
    var list1 = favoriteSnapshot.documents;
    for(var i = 0 ; i< list1.length; i ++){
      final Favorite temp = Favorite.fromSnapshot(list1[i]);
      favorite.add(temp);
    }

    QuerySnapshot querySnapshot =
    await Firestore.instance.collection("restaurant").getDocuments();
    var list = querySnapshot.documents;
    // build init 할 때 user collection -> uid document -> search_history collection -> index 돌면서 추가!

    setState(() {
      for (var i = 0; i < favorite.length; i++) {
        for(int j = 0; j< list.length; j++){
          final Restaurant restaurant = Restaurant.fromSnapshot(list[j]);
          if(restaurant.name == favorite[i].name) favoriteList.add(restaurant);
        }

      }
    });




  }

  @override
  void initState() {
    _buildList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: (){
            Navigator.of(context)
                .push(MaterialPageRoute(
                builder: (BuildContext context) =>
                    HomePage(
                      user: user,
                    )))
                .catchError((e) => print(e));
          },
        )
      ),
      body: ListView.builder(
        itemCount: favoriteList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: Image.network('${favoriteList[index].logo}').image,
            ),
              title: Text(favoriteList[index].name),
              subtitle: Text("영업시간: " + favoriteList[index].time),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            DetailPage(
                                user: user,
                                restaurant: favoriteList[index],
                                previous: "favorite")))
                    .catchError((e) => print(e));
              }
              );
        }),
    );
  }
}
