import 'package:campus_map/apis/gebruiker_api.dart';
import 'package:campus_map/models/gebruiker.dart';
import 'package:campus_map/pages/home.dart';
import 'package:campus_map/pages/ranking.dart';
import 'package:campus_map/widgets/BottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class InfoPage extends StatefulWidget {
  final num score;

  const InfoPage({Key key, this.score}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _InfoPageState(score);
}

class _InfoPageState extends State {
  final num score; 
  _InfoPageState(this.score);
  String antwoord;
  FToast fToast;
  TextEditingController rNummerController = TextEditingController();
  TextEditingController naamController = TextEditingController();
  Gebruiker gebruiker = Gebruiker();

  @override
  void initState() {
    super.initState();
    
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Campus Map"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.topCenter,
              color: Colors.white,
              child: Text("Vul hier uw gegevens in",
              style: TextStyle(color: Colors.black, fontSize: 36.0),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.topCenter,
              color: Colors.white,
              child: 
              Text("Uw score op de vraag: " + score.toString() + "/1"),
            ),
            TextField(
              controller: rNummerController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Geef uw r-nummer"
              ),
            ),
            TextField(
              controller: naamController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Geef uw naam indien dit uw eerste keer is"
              ),
            ),
            RaisedButton(
                  textColor: Colors.white,
                  color: Colors.teal,
                  child: Text("Slaag je score op"),
                  onPressed: () => _postScoreAndNavigateRanking(),
                ),
          ], 
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  _showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.redAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.clear),
          SizedBox(
            width: 12.0,
          ),
          Text("Gelieve een antwoord aan te duiden."),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.CENTER,
      toastDuration: Duration(seconds: 2),
    );
  }

  void _postScoreAndNavigateRanking() {
    if (naamController.text != "") {
      gebruiker.naam = naamController.text;
      gebruiker.rNummer = rNummerController.text.toUpperCase();
      gebruiker.score = score;
      GebruikersApi.createGebruiker(gebruiker);
    }
    else {
      GebruikersApi.fetchGebruikerByRnummer(rNummerController.text.toUpperCase()).then((result) {
        gebruiker = result;
        gebruiker.score += score;
        GebruikersApi.updateGebruiker(gebruiker.id, gebruiker);
      });
    }
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
  }
}
