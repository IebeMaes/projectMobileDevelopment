import 'package:campus_map/widgets/arpoiwithdetail.dart';
import 'package:flutter/material.dart';


class ArPoiPage extends StatefulWidget {
  @override
  _ArPoiPageState createState() => _ArPoiPageState();
}

class _ArPoiPageState extends State<ArPoiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Campus Map"),
      ),
      body: Center(
          child: ArPoiWithDetailWidget()),
    );
  }
}