import 'package:flutter/foundation.dart';

enum Category { all, accessories, clothing, home,}

class Product {
  Product({
    @required this.category,
    @required this.id,
    @required this.isFeatured,
    @required this.name,
    @required this.location,
    @required this.description,
    @required this.call,
  })  : assert(category != null),
        assert(id != null),
        assert(isFeatured != null),
        assert(name != null),
        assert(location != null),
        assert(description != null),
        assert(call != null);


  final Category category;
  final int id;
  final bool isFeatured;
  final String name;
  final String location;
  final String description;
  final String call;
  bool favorite = false;

  String get assetName => '$id-0.jpeg';
  // String get assetPackage => 'shrine_images';
  String get assetPackage => 'images';

  @override
  String toString() => "$name (id=$id)";
}
