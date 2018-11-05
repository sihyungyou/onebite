import 'package:flutter/material.dart';
import 'model/product.dart';
import 'home.dart';

class DetailPage extends StatefulWidget {
  // Declare a field that holds the Todo
  final Product hotels;
  

  // In the constructor, require a Todo
  DetailPage({Key key, @required this.hotels}) : super(key: key);

  @override
  DetailPageState createState() {
    return new DetailPageState(hotels2: hotels);
  }
}

class DetailPageState extends State<DetailPage> {
  final Product hotels2;
  DetailPageState({Key key, @required this.hotels2});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
      ),
      body: ListView(children: [
        // photoSection,
        Stack(
          children: <Widget>[
            SizedBox(
              child: new PhotoHero(
                photo: 'images/' + hotels2.assetName,
                width: 500.0,
              ),
                height: 300.0,
                // fit: BoxFit.cover,
            ),
            Positioned(
                top: 10.0,
                right: 10.0,
                child: IconButton(
                    icon: new Icon(
                      hotels2.favorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      setState(() {
                        hotels2.favorite = !hotels2.favorite;
                      });
                      print(hotels2.id);
                      print(hotels2.name);
                      print(hotels2.favorite);                      
                    }))
          ],
        ),
        // titleSection,
        Container(
          padding: const EdgeInsets.all(32.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        '${hotels2.name}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.location_on,
                            color: Colors.lightBlue,
                          ),
                          Container(
                            width: 15.0,
                          ),
                          Text('${hotels2.location}',
                              style: TextStyle(
                                color: Colors.lightBlue[300],
                              ))
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.call,
                          color: Colors.lightBlue,
                        ),
                        Container(
                          width: 15.0,
                        ),
                        Text(
                          '${hotels2.call}',
                          style: TextStyle(
                            color: Colors.lightBlue[300],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        // dividerSection,
        Divider(height: 1.0, color: Colors.black),
        // textSection,
        Container(
          padding: const EdgeInsets.all(32.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        '${hotels2.description}',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
