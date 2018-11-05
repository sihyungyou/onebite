// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'home.dart';
import 'login.dart';
import 'search.dart';
import 'detail.dart';
import 'favorite.dart';
import 'ranking.dart';
import 'mypage.dart';
import 'language_selector_page.dart';
import 'application.dart';
import 'app_translations_delegate.dart';

class ShrineApp extends StatefulWidget {
  @override
  ShrineAppState createState() {
    return new ShrineAppState();
  }
}

class ShrineAppState extends State<ShrineApp> {
  AppTranslationsDelegate _newLocaleDelegate;

  @override
  void initState() {
    super.initState();
    _newLocaleDelegate = AppTranslationsDelegate(newLocale: null);
    application.onLocaleChanged = onLocaleChange;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shrine',
      home: HomePage(),
      localizationsDelegates: [
        _newLocaleDelegate,
        const AppTranslationsDelegate(),
        //provides localised strings
        GlobalMaterialLocalizations.delegate,
        //provides RTL support
        GlobalWidgetsLocalizations.delegate,
      ],
      // supportedLocales: application.supportedLocales(),
      supportedLocales: application.supportedLocales(),

      initialRoute: '/home',
      routes: {
        // When we navigate to the "/home" route, build the HomePage Widget
        '/home': (context) => HomePage(),
        '/search': (context) => SearchPage(),
        '/detail': (context) => DetailPage(),
        '/favorite': (context) => FavoritePage(),
        '/ranking': (context) => RankingPage(),
        '/my': (context) => MyPage(),
        '/lang': (context) => LanguageSelectorPage(),
      },
      onGenerateRoute: _getRoute,
    );
  }

  void onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
    });
  }

  Route<dynamic> _getRoute(RouteSettings settings) {
    if (settings.name != '/login') {
      return null;
    }

    return MaterialPageRoute<void>(
      settings: settings,
      builder: (BuildContext context) => LoginPage(),
      fullscreenDialog: true,
    );
  }
}
