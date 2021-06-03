
import 'package:campus_map/pages/arpoi.dart';
import 'package:campus_map/pages/ranking.dart';
import 'package:flutter/material.dart';
import './pages/home.dart';


void main() => runApp(new CampusMapApp());

class CampusMapApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Campus map app',
      theme: ThemeData(
        primaryColor: Colors.deepOrange
      ),
      //home: HomePage(),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/ar': (context) => ArPoiPage(),
        '/ranking': (context) => RankingPage()
      },
    );
  }

  

  
}