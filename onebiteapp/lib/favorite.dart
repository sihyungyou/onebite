import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'model/product.dart';

// MyApp is a StatefulWidget. This allows us to update the state of the
// Widget whenever an item is removed.
class FavoritePage extends StatefulWidget {
  final List<Product> favhotels;
  Set<int> favoriteIds = new Set<int>();

  FavoritePage({Key key, @required this.favhotels, this.favoriteIds}) : super(key: key);

  @override
  FavoritePageState createState() {
    return FavoritePageState();
    // return FavoritePageState(favstatehotels: favhotels);
  }
}

class FavoritePageState extends State<FavoritePage> {
  // final items = List<String>.generate(3, (i) => "Item ${i + 1}");
  // final List<Product> favstatehotels;
  // FavoritePageState({Key key, @required this.favstatehotels});

  @override
  Widget build(BuildContext context) {
    final title = 'Favorite Hotels';

    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
            ),
          title: Text(title),
        ),
        body: ListView.builder(
            // itemCount: favstatehotels.length,
            itemCount: widget.favhotels.length,
            itemBuilder: (context, index) {
              // index = favstatehotels[index].id;
              // final item = favstatehotels[index];
              final item = widget.favhotels[index];

              if (item.favorite == true) {
                return Dismissible(
                  // Each Dismissible must contain a Key. Keys allow Flutter to
                  // uniquely identify Widgets.

                  key: Key(item.name),

                  // We also need to provide a function that tells our app
                  // what to do after an item has been swiped away.
                  onDismissed: (direction) {
                    // Remove the item from our data source.
                    setState(() {
                      item.favorite = false;
                      // favstatehotels.removeAt(index);
                      widget.favhotels.removeAt(index);
                    });

                    // Then show a snackbar!
                    // Scaffold.of(context).showSnackBar(
                    //     SnackBar(content: Text("$item dismissed")));
                  },
                  // Show a red background as the item is swiped away
                  background: Container(color: Colors.red),
                  child: ListTile(title: Text('${item.name}')),
                );
              }
            } 
          ),
      ),
    );
  }
}
