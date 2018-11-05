import 'package:flutter/material.dart';
import 'home.dart';
import 'login.dart';
import 'search.dart';
import 'rest_detail.dart';
import 'favorite.dart';
import 'bug_report.dart';
import 'suggestion.dart';
import 'sign_inup.dart';
import 'sign_up.dart';
import 'notice_list.dart';
import 'notice_detail.dart';
import 'event_list.dart';
import 'event_detail.dart';
import 'history.dart';
import 'rest_all.dart';
import 'rest_detail.dart';

class OnebiteApp extends StatefulWidget {
  @override
  OnebiteAppState createState() {
    return new OnebiteAppState();
  }
}

class OnebiteAppState extends State<OnebiteApp> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme color 적용
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],
      ),

      // title: 'Shrine',
      
      // 앱 켰을 시, 루트 페이지 설정
      home: HomePage(),
      initialRoute: '/home',

      // 각 페이지별 루트 설정
      routes: {
        '/home': (context) => HomePage(),
        '/search': (context) => SearchPage(),
        '/detail': (context) => DetailPage(),
        '/favorite': (context) => FavoritePage(),
        '/login': (context) => LoginPage(),
        '/bug_report' : (context) => BugReportPage(),
        // '/event_list' : (context) =>
        // '/event_detail' : (context) =>
        // '/history' : (context) =>
        // '/notice_detail' : (context) =>
        '/notice_list' : (context) => NoticeListPage(),
        // '/rest_all' : (context) =>
        // '/rest_detail' : (context) =>
        '/suggestion' : (context) => SuggestionPage(),
        // '/sign_inup' : (context) =>
        // '/sign_up' : (context) =>
      },
      // onGenerateRoute: _getRoute,  필요없을듯
    );
  }
  // 얘도 필요없을 듯
  // Route<dynamic> _getRoute(RouteSettings settings) {
  //   if (settings.name != '/login') {
  //     return null;
  //   }

  //   return MaterialPageRoute<void>(
  //     settings: settings,
  //     builder: (BuildContext context) => LoginPage(),
  //     fullscreenDialog: true,
  //   );
  // }
}
