import 'package:campus_map/pages/arpoi.dart';
import 'package:campus_map/widgets/BottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:augmented_reality_plugin_wikitude/wikitude_plugin.dart';
import 'package:augmented_reality_plugin_wikitude/wikitude_response.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> features = ["geo"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Map van de campus"),
      ),
      body: SingleChildScrollView(
        
        child: Container(
            padding: EdgeInsets.all(30.0),
            alignment: Alignment.topCenter,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Campus Geel",
                  textDirection: TextDirection.ltr,
                  style: TextStyle(color: Colors.black, fontSize: 36.0),
                ),
                new SizedBox(height: 30),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text(
                      "Adres:",
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
                new SizedBox(height: 10),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    child: Text(
                      "Kleinhoefstraat 4, 2440 Geel",
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      child: new RaisedButton(
                        textColor: Colors.white,
                        color: Colors.teal,
                        child: Text("Openen in Google Maps"),
                        onPressed: () =>
                            launch("https://goo.gl/maps/sobar5v8FwFc8Gez9"),
                      ),
                    ),
                  ),
                ),
                new SizedBox(height: 30),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text(
                      "Grondplan:",
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
                new SizedBox(height: 10),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                      child:
                          new Image.asset('assets/campusplan_geel_small.jpg')),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      child: new RaisedButton(
                        textColor: Colors.white,
                        color: Colors.teal,
                        child: Text("Open de AR ervaring"),
                        onPressed: () =>
                            navigateToPoi(),
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  void navigateToPoi() {
    print("Navigeren naar de poi pagina");
    this.checkDeviceCompatibility().then((value) => {
            if (value.success)
              {
                this.requestARPermissions().then((value) => {
                      if (value.success)
                        {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ArPoiPage()),
                          )
                        }
                      else
                        {
                          debugPrint("AR permissions denied"),
                          debugPrint(value.message)
                        }
                    })
              }
            else
              {debugPrint("Device incompatible"), debugPrint(value.message)}
          });
  }

  Future<WikitudeResponse> checkDeviceCompatibility() async {
    return await WikitudePlugin.isDeviceSupporting(this.features);
  }

  Future<WikitudeResponse> requestARPermissions() async {
    return await WikitudePlugin.requestARPermissions(this.features);
  }
}
