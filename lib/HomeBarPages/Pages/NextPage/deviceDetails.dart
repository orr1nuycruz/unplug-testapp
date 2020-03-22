import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_app1/model/devices.dart';

class DeviceDetails extends StatefulWidget {
  //final DeviceList device;
  final DocumentSnapshot getDevice;

  //DeviceDetails({Key key, this.device}) : super(key: key);
  DeviceDetails({this.getDevice});

  @override
  _DeviceDetailsState createState() => _DeviceDetailsState();
}

class _DeviceDetailsState extends State<DeviceDetails> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: Text("Device Details"),
        backgroundColor: Colors.green,
      ),
      body: new Container(
        child: Center(
          child: new Column(
            children: <Widget>[
              new IconButton(
                icon: new Icon(Icons.adb, color: Colors.green),
                iconSize: 60,
                onPressed: () {
                  Navigator.of(context).pushNamed("/");
                },
              ),
              new Text(
                widget.getDevice.data['deviceName'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
              new Text(
                "ID: " + widget.getDevice.data['deviceId'].toString(),
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
              new Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      title: Text(
                        "Statistics",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                      
                    ),
                    ListTile(
                      title: Text("Status"),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                      trailing: Text(
                        widget.getDevice.data["status"],
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListTile(
                      title: Text("Voltage"),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                      trailing: Text(
                        widget.getDevice.data["voltage"] + " V",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListTile(
                      title: Text("Current"),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                      trailing: Text(
                        widget.getDevice.data["current"] + " A",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListTile(
                      title: Text("Power"),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                      trailing: Text(
                        widget.getDevice.data["power"] + " W",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListTile(
                      title: Text("Energy Savings"),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                      trailing: Text(
                        widget.getDevice.data["energySavings"] + " W",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListTile(
                      title: Text("Trees saved"),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                          trailing: Text(
                        widget.getDevice.data["treesSaved"],
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Total Savings",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                      trailing: Text(
                        r"$ " + widget.getDevice.data["totalSavings"],
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
