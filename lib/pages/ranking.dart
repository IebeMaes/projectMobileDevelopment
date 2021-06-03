import 'package:campus_map/apis/gebruiker_api.dart';
import 'package:campus_map/models/gebruiker.dart';
import 'package:campus_map/widgets/BottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RankingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RankingPageState();
}

class _RankingPageState extends State {
  List<Gebruiker> gebruikersList = List<Gebruiker>();
  String antwoord;
  FToast fToast;
  int count = 0;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    _getGebruikers();
  }

  void _getGebruikers() {
    GebruikersApi.fetchGebruikers().then((result) {
      setState(() {
        gebruikersList = result;
        gebruikersList.sort((a, b) => b.score.compareTo(a.score));
        count = result.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Campus Map - Ranking"),
      ),
      body: SingleChildScrollView(
        child: Container(
          //padding: EdgeInsets.all(30.0),
          alignment: Alignment.topCenter,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(
                height: MediaQuery.of(context).size.height,
                child: _gebruikersListItems(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  ListView _gebruikersListItems() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.red,
              child: Text(
                this.gebruikersList[position].score.toString(),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            title: Text(this.gebruikersList[position].naam),
          ),
        );
      },
    );
  }
}
