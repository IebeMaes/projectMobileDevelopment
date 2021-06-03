import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      color: Colors.deepOrange,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox.fromSize(
            size: Size(MediaQuery.of(context).size.width / 3,
                75), // button width and height
            child: Material(
              color: Colors.deepOrange, // button color
              child: InkWell(
                splashColor: Colors.green, // splash color
                onTap: () {
                  Navigator.pushReplacementNamed(context, "/");
                  print("Home Pressed");
                }, // button pressed
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.home), // icon
                    Text("Home"), // text
                  ],
                ),
              ),
            ),
          ),
          SizedBox.fromSize(
            size: Size(MediaQuery.of(context).size.width / 3,
                75), // button width and height
            child: Material(
              color: Colors.deepOrange, // button color
              child: InkWell(
                splashColor: Colors.green, // splash color
                onTap: () {
                  Navigator.pushNamed(context, "/ar");
                  print("AR Pressed");
                }, // button pressed
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.dock), // icon
                    Text("AR"), // text
                  ],
                ),
              ),
            ),
          ),
          SizedBox.fromSize(
            size: Size(MediaQuery.of(context).size.width / 3,
                75), // button width and height
            child: Material(
              color: Colors.deepOrange, // button color
              child: InkWell(
                splashColor: Colors.green, // splash color
                onTap: () {
                  print("Ranking Pressed");
                  Navigator.pushReplacementNamed(context, "/ranking");
                }, // button pressed
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.star), // icon
                    Text("Ranking"), // text
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
