// 전체식당
import 'package:flutter/material.dart';

class RestAllPage extends StatefulWidget {
  @override
  _RestAllPageState createState() => _RestAllPageState();
}

class _RestAllPageState extends State<RestAllPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("전체 식당")
      ),
    );
  }
}