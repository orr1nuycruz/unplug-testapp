import 'dart:math';
import 'package:flutter/material.dart';
import 'package:test_app1/HomeBarPages/Shared/loading.dart';
import 'package:test_app1/model/cloudDevicesModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CloudDeviceDetails extends StatefulWidget {
  final DevicefromCloud device;
  _CloudDeviceDetailsState createState() => _CloudDeviceDetailsState();
  CloudDeviceDetails({Key key, this.device}) : super(key: key);
}

class _CloudDeviceDetailsState extends State<CloudDeviceDetails> {
  String id;
  var random = Random.secure();
  final db = Firestore.instance;
  bool loading = false;

  @override
  initState() {
    super.initState();
  }

  void showMessage() {
    Fluttertoast.showToast(
        msg: "HEllo nigga",
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  

  @override
  Widget build(BuildContext context) {
    
    return loading
        ? Loading()
        : new Scaffold(
              appBar: new AppBar(
                title: Text("The Cloud"),
                backgroundColor: Colors.green,
              ),
              body: new Container(
                child: Center(
                  child: new Column(
                    children: <Widget>[
                      new IconButton(
                        icon: new Icon(Icons.cloud, color: Colors.green),
                        iconSize: 60,
                        onPressed: () {
                          Navigator.of(context).pushNamed("/");
                        },
                      ),
                      new Text(
                        widget.device.applianceType,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
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
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 0),
                            ),
                            ListTile(
                              title: Text("Status"),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 0),
                              trailing: Text(
                                "${widget.device.state.toString()}",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                            ListTile(
                              title: Text("Energy Consumption"),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 0),
                              trailing:
                                  Text("${widget.device.power.toString()} W"),
                            ),
                            ListTile(
                              title: Text("Energy Savings"),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 0),
                              trailing: Text(
                                  "${widget.device.energySavings.toString()} W"),
                            ),
                            ListTile(
                              title: Text("CO2e saved"),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 0),
                              trailing: Text(
                                  "${widget.device.treesSaved.toString()} CO2e"),
                            ),
                            ListTile(
                              title: Text(
                                "Total Savings",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 0),
                              trailing: Text(
                                r"$ " + widget.device.dollarSavings.toString(),
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      new RaisedButton(
                          child: new Text('Add Device'),
                          onPressed: () {
                            createData();
                            showMessage();
                            Navigator.pop(context, true);
                          }),
                    ],
                  ),
                ),
              ),
            );
  }

  void createData() async {
    int num = random.nextInt(9999 - 1000);
    DocumentReference ref = await db.collection('Devices Available').add({
      'deviceName': widget.device.applianceType,
      'deviceId': num,
      'time': widget.device.time,
      'current': widget.device.current,
      'voltage': widget.device.voltage,
      'power': widget.device.power,
      'status': widget.device.state,
      'energySavings': widget.device.energySavings,
      'totalSavings': widget.device.dollarSavings,
      'treesSaved': widget.device.treesSaved,
    });
  }
}
