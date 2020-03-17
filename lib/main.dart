import 'package:flutter/material.dart';
import 'package:test_app1/HomeBarPages/Navigation.dart';
import 'HomeBarPages/Pages/DeviceFromCloud.dart';

void main() {
  runApp(
    new MaterialApp(
      home: Homepage(),
      routes: <String, WidgetBuilder>{
        "/SecondPage": (BuildContext context) => new SecondPage(),
        "/CloudDevice": (BuildContext context) => new DevicesFromCloud(),
      },
    ),
  );
}

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Home Devices"),
        backgroundColor: Colors.green,
      ),
      body: new Container(
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new IconButton(
                icon: new Icon(Icons.favorite, color: Colors.greenAccent),
                iconSize: 60,
                onPressed: () {
                  Navigator.of(context).pushNamed("/SecondPage");
                },
              ),
              new Text("Home")
            ],
          ),
        ),
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      home: BottomNavigatorPage()
    );
  }
 
}
