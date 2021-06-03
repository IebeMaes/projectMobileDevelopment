import 'dart:math';

import 'package:campus_map/apis/blok_api.dart';
import 'package:campus_map/apis/vraag_api.dart';
import 'package:campus_map/models/blok.dart';
import 'package:campus_map/models/vraag.dart';
import 'package:campus_map/pages/info.dart';
import 'package:campus_map/widgets/BottomNavBar.dart';
import 'package:custom_radio_grouped_button/CustomButtons/ButtonTextStyle.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomRadioButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

class QuizPage extends StatefulWidget {
  final num id;

  const QuizPage({Key key, this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QuizPageState(id);
}

class _QuizPageState extends State {
  final num id;
  List<Vraag> vraagList = List<Vraag>();
  Blok blok = Blok();
  _QuizPageState(this.id);
  String antwoord;
  FToast fToast;
  final _random = new Random();
  num vraagNummer;

  @override
  void initState() {
    super.initState();
    _getVragen();
    fToast = FToast();
    fToast.init(context);
  }

  void _getVragen() async {
    await VragenApi.fetchVragenByBlokId(id).then((result) async {
      if (result != null) {
        setState(() {
          vraagList = result;
        });
        vraagNummer = _random.nextInt(vraagList.length);
        num blokId = vraagList[vraagNummer].blokId;
        await BlokApi.fetchBlok(blokId).then((value) {
          setState(() {
            blok = value;
          });
        });
      }
      if (result == null) {
        Navigator.pushNamed(context, '/');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (blok.id != null) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Campus Map"),
        ),
        body: SingleChildScrollView(
          child: Container(
            //padding: EdgeInsets.all(30.0),
            alignment: Alignment.topCenter,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "Campus Geel - " + blok.title,
                    textDirection: TextDirection.ltr,
                    style: TextStyle(color: Colors.black, fontSize: 36.0),
                  ),
                ),
                new SizedBox(height: 30),
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: new BoxDecoration(
                      color: Colors.teal[300],
                      borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(20.0),
                        topRight: const Radius.circular(20.0),
                        bottomLeft: const Radius.circular(20.0),
                        bottomRight: const Radius.circular(20.0),
                      )),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          child: Text(
                            "Vraag:",
                            textDirection: TextDirection.ltr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          child: Text(
                            vraagList[vraagNummer].vraag,
                            textDirection: TextDirection.ltr,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 30.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                new SizedBox(height: 30),
                CustomRadioButton(
                  elevation: 5,
                  absoluteZeroSpacing: false,
                  unSelectedColor: Colors.grey[300],
                  buttonLables: [
                    vraagList[vraagNummer].antwoord1,
                    vraagList[vraagNummer].antwoord2,
                    vraagList[vraagNummer].antwoord3,
                  ],
                  buttonValues: [
                    "antwoord1",
                    "antwoord2",
                    "antwoord3",
                  ],
                  buttonTextStyle: ButtonTextStyle(
                      selectedColor: Colors.black,
                      unSelectedColor: Colors.black,
                      textStyle: TextStyle(fontSize: 25)),
                  radioButtonValue: (value) {
                    this.antwoord = value;
                    print(this.antwoord);
                    print(vraagList[vraagNummer].juist);
                  },
                  selectedColor: Colors.tealAccent,
                  enableShape: true,
                  horizontal: true,
                  height: 80,
                  unSelectedBorderColor: Colors.transparent,
                  selectedBorderColor: Colors.transparent,
                  spacing: 5,
                ),
                RaisedButton(
                  textColor: Colors.white,
                  color: Colors.teal,
                  child: Text("Check de score"),
                  onPressed: () => _checkAnswerAndNavigateHome(),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavBar(),
      );
    }
    if (blok.id == null) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Campus Map"),
        ),
        body: SingleChildScrollView(
          child: Container(
            //padding: EdgeInsets.all(30.0),
            alignment: Alignment.topCenter,
            color: Colors.white,
            child: Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Gelieve nog even te wachten, data wordt geladen!",
                      textDirection: TextDirection.ltr,
                      style: TextStyle(color: Colors.black, fontSize: 36.0),
                    ),
                    new SizedBox(height: 30),
                    SpinKitDoubleBounce(
                      color: Colors.black,
                      size: 200,
                    )
                  ],
                )),
          ),
        ),
        bottomNavigationBar: BottomNavBar(),
      );
    }
  }

  void _checkAnswerAndNavigateHome() {
    if (this.antwoord == null) {
      _showToast();
    } else {
      num score;
      if (this.antwoord == vraagList[vraagNummer].juist) {
        score  = 1;
      }else{
        score  = 0;
      }
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => InfoPage(score: score)));
    }
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
}
