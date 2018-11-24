import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Shrine/rest_all.dart';

class DetailPage extends StatefulWidget {
  final FirebaseUser user;
  final Restaurant restaurant;
  List<Menu> menu = List<Menu>();
  DetailPage({Key key, this.user, this.restaurant});
  DetailPageState createState() => DetailPageState(user: this.user, restaurant: this.restaurant);
}

class DetailPageState extends State<DetailPage> {
   final FirebaseUser user;
   final Restaurant restaurant;
   DetailPageState({Key key, this.user, this.restaurant});

   void _buildList() async {
     QuerySnapshot querySnapshot = await Firestore.instance.collection("restaurants").document(restaurant.reference.documentID).collection('menu').getDocuments();
     var list = querySnapshot.documents;
     print(list.length);
     for (var i = 0; i < list.length; i++) {
       final Menu menu = Menu.fromSnapshot(list[i]);
       print(menu.name);
       print(menu.price);

     }
   }

   @override
  void initState() {
    // TODO: implement initState
    _buildList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

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
