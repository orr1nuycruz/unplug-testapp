import 'package:flutter/material.dart';
import 'package:test_app1/HomeBarPages/Navigation.dart';

void main() {
  runApp(
    new MaterialApp(
      home: Homepage(),
      routes: <String, WidgetBuilder>{
        "/SecondPage": (BuildContext context) => new SecondPage()
      },
    ),
  );
}

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
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
                icon: new Icon(Icons.desktop_windows, color: Colors.greenAccent),
                iconSize: 80,
                onPressed: () {
                  Navigator.of(context).pushNamed("/SecondPage");
                },
              ),
              new Text("Press on Icon to Continue")
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
