import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class AddPage extends StatefulWidget {

  @override
  AddPageState createState() {
    return new AddPageState();
  }
}

class AddPageState extends State<AddPage> {
  String name;
  String closed;
  String deliveryFee;
  String minimumOrder;
  String phone;
  String rate;
  String time;
  String type;
  //menu prices
  String price1;
  String price2;
  String price3;
  String price4;
  String price5;
  String price6;
  //menu names
  String menu1;
  String menu2;
  String menu3;
  String menu4;
  String menu5;
  String menu6;
  //top menu names
  String topmenu1;
  String topmenu2;
  String topmenu3;
  String topmenu4;
  String topmenu5;
  String topmenu6;
  //top menu price
  String topprice1;
  String topprice2;
  String topprice3;
  String topprice4;
  String topprice5;
  String topprice6;


  String menu;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.save,
            ),
            onPressed: () {
              final wordPair = WordPair.random();
              final wordPair2 = WordPair.random();
              final wordPair3 = WordPair.random();
              final form = formKey.currentState;
              form.save();
              Firestore.instance.collection('restaurant').document(wordPair.toString())
              .setData(({
                'name' : '${this.name}',
                'closed' : '${this.closed}',
                }));
              Firestore.instance.collection('restaurant').document(wordPair.toString()).collection('menu').document(wordPair2.toString())
              .setData(({
                'name' : '${this.menu1}',
                'price' : '${this.price1}',
                }));
                Firestore.instance.collection('restaurant').document(wordPair.toString()).collection('topmenu').document(wordPair3.toString())
              .setData(({
                'name' : '${this.topmenu1}',
                'price' : '${this.topprice1}',
                }));
            },
          )
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Form(
                      key: formKey,
                        child: Column(
                      children: <Widget>[
                        TextFormField(
                            decoration: InputDecoration(
                              labelText: 'name',
                            ),
                            onSaved: (String newName) {
                              this.name = newName;
                            }),
                        TextFormField(
                            decoration: InputDecoration(
                              labelText: 'closed',
                            ),
                            onSaved: (String newClosed) {
                              this.closed = newClosed;
                            }),
                            TextFormField(
                            decoration: InputDecoration(
                              labelText: 'top menu1',
                            ),
                            onSaved: (String newTopmenu) {
                              this.topmenu1 = newTopmenu;
                            }),
                            TextFormField(
                            decoration: InputDecoration(
                              labelText: 'top price1',
                            ),
                            onSaved: (String newTopprice) {
                              this.topprice1 = newTopprice;
                            }),
                            TextFormField(
                            decoration: InputDecoration(
                              labelText: 'menu1',
                            ),
                            onSaved: (String newMenu) {
                              this.menu1 = newMenu;
                            }),
                            TextFormField(
                            decoration: InputDecoration(
                              labelText: 'menu price1',
                            ),
                            onSaved: (String newMenuprice) {
                              this.price1 = newMenuprice;
                            }),
                      ],
                    )),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}