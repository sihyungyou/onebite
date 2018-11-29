// 전체식당
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'rest_detail.dart';
import 'rest_all.dart';

class FavoritePage extends StatefulWidget {
  @override
  final FirebaseUser user;
  List<Restaurant> favorite = new List<Restaurant>();
  FavoritePage({Key key, this.user, this.favorite});
  _FavoritePageState createState() => _FavoritePageState(user: user, favorite: favorite);
}

class _FavoritePageState extends State<FavoritePage> {
  final FirebaseUser user;
  List<Restaurant> favorite;
  _FavoritePageState({Key key, this.user, this.favorite});


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: favorite.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: Image.network('${favorite[index].logo}').image,
            ),
              title: Text(favorite[index].name),
              subtitle: Text("영업시간: " + favorite[index].time),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            DetailPage(
                                user: user,
                                restaurant: favorite[index])))
                    .catchError((e) => print(e));
              }
              );
        }),
    );
  }
}
