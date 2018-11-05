import 'package:flutter/material.dart';
import 'detail.dart';
import 'model/products_repository.dart';
import 'model/product.dart';
import 'favorite.dart';

//hero animation class
class PhotoHero extends StatelessWidget {
  PhotoHero({Key key, this.photo, this.onTap, this.width}) : super(key: key);
  final double width;
  final String photo;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new SizedBox(
      width: width,
      child: new Hero(
        tag: photo,
        child: Material(
            child: InkWell(
              onTap: onTap,
          child: Image.asset(photo),
        )),
      ),
    );
  }
}

class HomePage extends StatelessWidget {

  List<Product> products = ProductsRepository.loadProducts(Category.all);
  
  //this is scaffoldkey for drawer openenr
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  // HomePage({Key key, @required this.products}) : super(key: key);

  List<Card> _buildGridCards(BuildContext context) {
    if (products == null || products.isEmpty) {
      return const <Card>[];
    }

    final ThemeData theme = Theme.of(context);

    return products.map((product) {
      return Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //hero goes here. image를 감싸야함.
            AspectRatio(
              aspectRatio: 18 / 11,
              child: PhotoHero(
                width: 300.0,
                photo: 'images/' + product.assetName,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(hotels: product),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 200.0,
                      child: Text(
                        product.name,
                        style: theme.textTheme.title,
                        maxLines: 1,
                      ),
                    ),
                    // Text(
                    //   product.name,
                    //   style: theme.textTheme.title,
                    //   maxLines: 1,
                    // ),
                    SizedBox(height: 3.0),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          color: Colors.lightBlue,
                        ),
                        SizedBox(
                          width: 58.0,
                          // height:
                          child: Text(
                            product.location,
                            style: theme.textTheme.body2,
                          ),
                        ),
                        Container(
                          width: 69.0,
                          // height: 10.0,
                          child: FlatButton(
                            textColor: Colors.lightBlue,
                            //more을 누르면 hero 라면 이 flatbutton에서는 onpressed 에 히어로 액션걸어줘야함
                            child: Text('more'),
                            onPressed: () {
                              print('flatbutton-more');
                              print(product.assetName);
                              print(product.assetPackage);
                              print(product.id);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailPage(hotels: product),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      child: Text(
                        'Pages',
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
                // Update the state of the app
                // ...
                // Then close the drawer
                print('drawer-home');
                Navigator.pushNamed(context, '/home');
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.search,
                color: Colors.lightBlue,
              ),
              title: Text('Search'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                print('drawer-search');
                Navigator.pushNamed(context, '/search');
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.location_city,
                color: Colors.lightBlue,
              ),
              title: Text('Favorite Hotel'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                print('drawer-fav');
                //send list of product
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavoritePage(favhotels: products),
                    ),
                  );
                // _pushSaved();
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
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
        title: Text('Main'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              semanticLabel: 'search',
            ),
            onPressed: () {
              print('Search button');
              // navigate to SearchPage
              Navigator.pushNamed(context, '/search');
            },
          ),
          IconButton(
            icon: Icon(
              Icons.tune,
              semanticLabel: 'filter',
            ),
            onPressed: () {
              print('Filter button');
              Navigator.pushNamed(context, '/lang');
            },
          ),
        ],
      ),
      // orientationbuilder used for turning screen
      body: OrientationBuilder(
        builder: (context, orientation) {
          return GridView.count(
            crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
            padding: EdgeInsets.all(16.0),
            childAspectRatio: 8.0 / 9.0,
            children: _buildGridCards(context),
          );
        },
      ),
    );
  }
}
